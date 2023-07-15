resource "azurerm_resource_group" "onprem_rg" {
  name     = var.onprem_resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "onprem_vnet" {
  name                = var.onprem_vnet_name
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.onprem_rg.name
  address_space       = ["172.168.0.0/16"]
}

resource "azurerm_subnet" "onprem_subnet" {
  name                 = var.onprem_subnet_name
  resource_group_name  = azurerm_resource_group.onprem_rg.name
  virtual_network_name = azurerm_virtual_network.onprem_vnet.name
  address_prefixes     = ["172.168.1.0/24"]
}

resource "azurerm_subnet" "onprem_gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.onprem_rg.name
  virtual_network_name = azurerm_virtual_network.onprem_vnet.name
  address_prefixes     = ["172.168.255.224/27"]
}

# Create public IPs
resource "azurerm_public_ip" "onprem_public_ip" {
  name                = "onprem-public-ip"
  location            = azurerm_resource_group.onprem_rg.location
  resource_group_name = azurerm_resource_group.onprem_rg.name
  allocation_method   = "Static"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "onprem_nsg" {
  name                = var.onprem_nsg_name
  location            = azurerm_resource_group.onprem_rg.location
  resource_group_name = azurerm_resource_group.onprem_rg.name

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
resource "azurerm_network_interface" "onprem_nic" {
  name                = var.onprem_nic_name
  location            = azurerm_resource_group.onprem_rg.location
  resource_group_name = azurerm_resource_group.onprem_rg.name

  ip_configuration {
    name                          = "onprem_nic_configuration"
    subnet_id                     = azurerm_subnet.onprem_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.onprem_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "onprem_nisga" {
  network_interface_id      = azurerm_network_interface.onprem_nic.id
  network_security_group_id = azurerm_network_security_group.onprem_nsg.id
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "onprem_storage_account" {
  name                     = var.onprem_storage_account_name
  resource_group_name      = azurerm_resource_group.onprem_rg.name
  location                 = azurerm_resource_group.onprem_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create (and display) an SSH key
resource "tls_private_key" "onprem_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "onprem_vm" {
  name                  = var.onprem_vm_name
  resource_group_name   = azurerm_resource_group.onprem_rg.name
  location              = azurerm_resource_group.onprem_rg.location
  size                  = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.onprem_nic.id]

  os_disk {
    name                 = "onpremOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "onpremvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.onprem_ssh_key.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.onprem_storage_account.primary_blob_endpoint
  }
}

resource "azurerm_public_ip" "onprem_vpn_gateway_public_ip" {
  name                = "onprem-vpn-gateway-public-ip"
  location            = azurerm_resource_group.onprem_rg.location
  resource_group_name = azurerm_resource_group.onprem_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "onprem_vpn_gateway" {
  name                = "onprem-vpn-gateway"
  location            = azurerm_resource_group.onprem_rg.location
  resource_group_name = azurerm_resource_group.onprem_rg.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw1"
  ip_configuration {
    name                 = "onprem-vpn-gateway-ip-configuration"
    public_ip_address_id = azurerm_public_ip.onprem_vpn_gateway_public_ip.id
    subnet_id            = azurerm_subnet.onprem_gateway_subnet.id
  }
}