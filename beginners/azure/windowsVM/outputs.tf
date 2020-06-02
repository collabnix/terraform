#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Windows VM - Outputs
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

output "resource-names" {
    description     =   "Print the names of the resources"
    value           =   {
        "Resource-Group-Name" =  azurerm_resource_group.rg.name
        "Vnet-Name"           =  azurerm_virtual_network.vnet.name
        "Subnet-Name"         =  azurerm_subnet.web.name
        "NSG-Name"            =  azurerm_network_security_group.nsg.name
        "NIC-Name"            =  azurerm_network_interface.nic.name
    }
}


output "public_ip_address" {
    value           =   azurerm_public_ip.pip.ip_address
}

output "win_vm_login" {
    description     =      "Credentials to login to the VM"
    value           = {
        "VM-Name"   =   azurerm_windows_virtual_machine.vm.name
        "Username"  =   azurerm_windows_virtual_machine.vm.admin_username
        "Password"  =   azurerm_windows_virtual_machine.vm.admin_password
    }  
}
