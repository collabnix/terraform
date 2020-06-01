#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Create a Linux VM 
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

#
# - Provider Block
#

provider "azurerm" {
    version         =   ">=2.6"
    client_id       =   var.client_id
    client_secret   =   var.client_secret
    subscription_id =   var.subscription_id
    tenant_id       =   var.tenant_id
    
    features {}
}

#
# - Create a Resource Group
#

resource "azurerm_resource_group" "rg" {
    name                  =   "${var.prefix}-rg"
    location              =   var.location
    tags                  =   var.tags
}

#
# - Create a Virtual Network
#

resource "azurerm_virtual_network" "vnet" {
    name                  =   "${var.prefix}-vnet"
    resource_group_name   =   azurerm_resource_group.rg.name
    location              =   azurerm_resource_group.rg.location
    address_space         =   [var.vnet_address_range]
    tags                  =   var.tags
}

#
# - Create a Subnet inside the virtual network
#

resource "azurerm_subnet" "web" {
    name                  =   "${var.prefix}-web-subnet"
    resource_group_name   =   azurerm_resource_group.rg.name
    virtual_network_name  =   azurerm_virtual_network.vnet.name
    address_prefixes      =   [var.subnet_address_range]
}

#
# - Create a Network Security Group
#

resource "azurerm_network_security_group" "nsg" {
    name                        =       "${var.prefix}-web-nsg"
    resource_group_name         =       azurerm_resource_group.rg.name
    location                    =       azurerm_resource_group.rg.location
    tags                        =       var.tags

    security_rule {
    name                        =       "Allow_SSH"
    priority                    =       1000
    direction                   =       "Inbound"
    access                      =       "Allow"
    protocol                    =       "Tcp"
    source_port_range           =       "*"
    destination_port_range      =       22
    source_address_prefix       =       "PASTE_YOUR_IP_ADDRESS_HERE" 
    destination_address_prefix  =       "*"
    
    }
}


#
# - Subnet-NSG Association
#

resource "azurerm_subnet_network_security_group_association" "subnet-nsg" {
    subnet_id                    =       azurerm_subnet.web.id
    network_security_group_id    =       azurerm_network_security_group.nsg.id
}


#
# - Public IP (To Login to Linux VM)
#

resource "azurerm_public_ip" "pip" {
    name                            =     "${var.prefix}-linuxvm-public-ip"
    resource_group_name             =     azurerm_resource_group.rg.name
    location                        =     azurerm_resource_group.rg.location
    allocation_method               =     var.allocation_method[0]
    tags                            =     var.tags
}

#
# - Create a Network Interface Card for Virtual Machine
#

resource "azurerm_network_interface" "nic" {
    name                              =   "${var.prefix}-linuxvm-nic"
    resource_group_name               =   azurerm_resource_group.rg.name
    location                          =   azurerm_resource_group.rg.location
    tags                              =   var.tags
    ip_configuration                  {
        name                          =  "${var.prefix}-nic-ipconfig"
        subnet_id                     =   azurerm_subnet.web.id
        public_ip_address_id          =   azurerm_public_ip.pip.id
        private_ip_address_allocation =   var.allocation_method[1]
    }
}


#
# - Create a Linux Virtual Machine
# 

resource "azurerm_linux_virtual_machine" "vm" {
    name                              =   "${var.prefix}-linuxvm"
    resource_group_name               =   azurerm_resource_group.rg.name
    location                          =   azurerm_resource_group.rg.location
    network_interface_ids             =   [azurerm_network_interface.nic.id]
    size                              =   var.virtual_machine_size
    computer_name                     =   var.computer_name
    admin_username                    =   var.admin_username
    admin_password                    =   var.admin_password
    disable_password_authentication   =   false

    os_disk  {
        name                          =   "${var.prefix}-linuxvm-os-disk"
        caching                       =   var.os_disk_caching
        storage_account_type          =   var.os_disk_storage_account_type
        disk_size_gb                  =   var.os_disk_size_gb
    }

    source_image_reference {
        publisher                     =   var.publisher
        offer                         =   var.offer
        sku                           =   var.sku
        version                       =   var.vm_image_version
    }

    tags                              =   var.tags

}

