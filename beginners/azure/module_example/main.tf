#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*     Using Modules in Terraform - Create a Vnet    *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

#
# - Provider Block
#

provider "azurerm" {
    client_id       =   var.client_id
    client_secret   =   var.client_secret
    subscription_id =   var.subscription_id
    tenant_id       =   var.tenant_id
    
    features {}
}

#
# - Deploy a Vnet in Azure
#


module "vnet" {
    source                 =    "./child_module"
    resource_group_name    =    "Collabnix-RG"
    location               =    "East US"
    virtual_network_name   =    "Collabnix-Vnet"
    vnet_address_range     =    "10.0.0.0/16"
    subnet_name            =    "Webserver-Subnet"
    subnet_address_range   =    "10.0.1.0/24"

}
