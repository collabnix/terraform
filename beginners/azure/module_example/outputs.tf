#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*  Root Module -  Outputs                           *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

output "resource-group-name" {
    description     =   "Print the name of the resource group"
    value           =   module.vnet.resource-group-name
}

output "resource-group-location" {
    description     =   "Print the location of the resource group"
    value           =   module.vnet.resource-group-location
}

output "virtual-network-name" {
    description     =   "Print the name of the virtual network"
    value           =   module.vnet.virtual-network-name
}

output "virtual-network-ip-range" {
    description     =   "Print the ip range of the virtual network"
    value           =   module.vnet.virtual-network-ip-range
}

output "subnet-name" {
    description     =   "Print the name of the subnet"
    value           =   module.vnet.subnet-name
}

output "subnet-ip-range" {
    description     =   "Print the ip range of the subnet"
    value           =   module.vnet.subnet-ip-range
}