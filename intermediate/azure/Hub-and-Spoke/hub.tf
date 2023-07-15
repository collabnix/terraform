resource "azurerm_resource_group" "hub_rg" {
  name     = var.hub_resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.hub_rg.name
  address_space       = ["192.168.0.0/16"]
}

resource "azurerm_subnet" "hub_subnet" {
  name                 = var.hub_subnet_name
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "hub_gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["192.168.255.224/27"]
}

# Create public IPs
resource "azurerm_public_ip" "hub_public_ip" {
  name                = "hub-public-ip"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  allocation_method   = "Static"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "hub_nsg" {
  name                = var.hub_nsg_name
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name

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
resource "azurerm_network_interface" "hub_nic" {
  name                = var.hub_nic_name
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name

  ip_configuration {
    name                          = "hub_nic_configuration"
    subnet_id                     = azurerm_subnet.hub_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.hub_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "hub_nisga" {
  network_interface_id      = azurerm_network_interface.hub_nic.id
  network_security_group_id = azurerm_network_security_group.hub_nsg.id
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "hub_storage_account" {
  name                     = var.hub_storage_account_name
  resource_group_name      = azurerm_resource_group.hub_rg.name
  location                 = azurerm_resource_group.hub_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create (and display) an SSH key
resource "tls_private_key" "hub_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "hub_vm" {
  name                  = var.hub_vm_name
  resource_group_name   = azurerm_resource_group.hub_rg.name
  location              = azurerm_resource_group.hub_rg.location
  size                  = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.hub_nic.id]

  os_disk {
    name                 = "hubOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "hubvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.hub_ssh_key.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.hub_storage_account.primary_blob_endpoint
  }
}

resource "azurerm_public_ip" "hub_vpn_gateway_public_ip" {
  name                = "hub-vpn-gateway-public-ip"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "hub_vpn_gateway" {
  name                = "hub-vpn-gateway"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw1"
  ip_configuration {
    name                          = "hub-vpn-gateway-ip-configuration"
    public_ip_address_id          = azurerm_public_ip.hub_vpn_gateway_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub_gateway_subnet.id
  }
}

resource "azurerm_virtual_network_gateway_connection" "hub-onprem-conn" {
  name                            = "hub-onprem-conn"
  location                        = azurerm_resource_group.hub_rg.location
  resource_group_name             = azurerm_resource_group.hub_rg.name
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.hub_vpn_gateway.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.onprem_vpn_gateway.id
  type                            = "Vnet2Vnet"
  shared_key                      = "Azure@123"
  routing_weight                  = 1
}

resource "azurerm_virtual_network_gateway_connection" "onprem-hub-conn" {
  name                            = "onprem-hub-conn"
  location                        = azurerm_resource_group.onprem_rg.location
  resource_group_name             = azurerm_resource_group.onprem_rg.name
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.onprem_vpn_gateway.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.hub_vpn_gateway.id
  type                            = "Vnet2Vnet"
  shared_key                      = "Azure@123"
  routing_weight                  = 1
}