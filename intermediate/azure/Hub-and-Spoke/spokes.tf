resource "azurerm_resource_group" "spoke_rg" {
  name     = var.spoke_resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "spoke_vnet" {
  count               = var.spoke_count
  name                = "${var.spoke_vnet_name_prefix}${format("%03d", count.index + 1)}"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  address_space       = ["10.${count.index + 1}.0.0/16"]
}

resource "azurerm_subnet" "spoke_subnet" {
  count                = var.spoke_count
  name                 = "${var.spoke_subnet_name_prefix}${format("%03d", count.index + 1)}"
  resource_group_name  = azurerm_resource_group.spoke_rg.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet[count.index].name
  address_prefixes     = ["10.${count.index + 1}.0.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "spoke_public_ip" {
  count               = var.spoke_count
  name                = "${var.spoke_public_ip_name_prefix}${format("%03d", count.index + 1)}"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  allocation_method   = "Static"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "spoke_nsg" {
  count               = var.spoke_count
  name                = "${var.spoke_nsg_name_prefix}${format("%03d", count.index + 1)}"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "spoke_nic" {
  count               = var.spoke_count
  name                = "${var.spoke_nic_name_prefix}${format("%03d", count.index + 1)}"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name

  ip_configuration {
    name                          = "spoke_nic_configuration"
    subnet_id                     = azurerm_subnet.spoke_subnet[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.spoke_public_ip[count.index].id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "spoke_nisga" {
  count                     = var.spoke_count
  network_interface_id      = azurerm_network_interface.spoke_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.spoke_nsg[count.index].id
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "spoke_storage_account" {
  count                    = var.spoke_count
  name                     = "${var.spoke_storage_account_name_prefix}${format("%03d", count.index + 1)}"
  resource_group_name      = azurerm_resource_group.spoke_rg.name
  location                 = azurerm_resource_group.spoke_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create (and display) an SSH key
resource "tls_private_key" "spoke_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "spoke_vm" {
  count                 = var.spoke_count
  name                  = "${var.spoke_vm_name_prefix}${format("%03d", count.index + 1)}"
  resource_group_name   = azurerm_resource_group.spoke_rg.name
  location              = azurerm_resource_group.spoke_rg.location
  size                  = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.spoke_nic[count.index].id]

  os_disk {
    name                 = "${var.spoke_vm_name_prefix}${format("%03d", count.index + 1)}_osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "spokevm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.spoke_ssh_key.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.spoke_storage_account[count.index].primary_blob_endpoint
  }
}