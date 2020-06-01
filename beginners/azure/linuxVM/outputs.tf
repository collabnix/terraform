#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Linux VM - Outputs
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

output "resource-group-name" {
    description     =   "Print the name of the resource group"
    value           =   azurerm_resource_group.rg.name
}

output "resource-group-location" {
    description     =   "Print the location of the resource group"
    value           =   azurerm_resource_group.rg.location
}

output "virtual-network-name" {
    description     =   "Print the name of the virtual network"
    value           =   azurerm_virtual_network.vnet.name
}

output "virtual-network-ip-range" {
    description     =   "Print the ip range of the virtual network"
    value           =   azurerm_virtual_network.vnet.address_space
}

output "subnet-name" {
    description     =   "Print the name of the subnet"
    value           =   azurerm_subnet.web.name
}

output "subnet-ip-range" {
    description     =   "Print the ip range of the subnet"
    value           =   [azurerm_subnet.web.address_prefixes]
}

output "linux_nic_name" {
    value           =   azurerm_network_interface.nic.name
}

output "public_ip_address" {
    value           =   azurerm_public_ip.pip.ip_address
}

output "linux_vm_login" {
    value           = {
        "username"  =   azurerm_linux_virtual_machine.vm.admin_username
        "password"  =   azurerm_linux_virtual_machine.vm.admin_password
    }  
}
