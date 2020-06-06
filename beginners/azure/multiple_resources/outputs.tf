#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*     Create multiple resources using for_each        *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

output "resource-group" {
    description =   "Map resource group name with location"
    value       =   { for i in azurerm_resource_group.rg: i.name => i.location }
}

output "vnet" {
    description =   "Print Vnet name and Address Space"
    value       =    {
        "Vnet_Name"     =   azurerm_virtual_network.vnet.name 
        "Vnet_Address"  =   azurerm_virtual_network.vnet.address_space  
    }
}

output "subnet" {
    description =   "Map subnet name with address_prefixes"
    value       =   { for s in azurerm_subnet.sn: s.name => s.address_prefixes }
}
