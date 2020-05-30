#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*     Create a Virtual Network in Azure             *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

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
    name        =   var.resource_group_name
    location    =   var.location
    tags        =   {
        "project"       =   "Collabnix"
        "deployed_with" =   "Terraform"
    }
}

#
# - Create a Virtual Network
#

resource "azurerm_virtual_network" "vnet" {
  resource_group_name   =   azurerm_resource_group.rg.name
  name                  =   var.virtual_network_name
  location              =   azurerm_resource_group.rg.location
  address_space         =   [var.vnet_address_range]
   tags                 =   {
        "project"       =   "Collabnix"
        "deployed_with" =   "Terraform"
    }
}

#
# - Create a Subnet inside the virtual network
#

resource "azurerm_subnet" "sn" {
   name                 =   var.subnet_name
   resource_group_name  =   azurerm_resource_group.rg.name
   virtual_network_name =   azurerm_virtual_network.vnet.name
   address_prefixes     =   [var.subnet_address_range]
}
