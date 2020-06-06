#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*          Host a Static Website on Azure Storage     *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

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
# - Create a Random integer to append to Storage account name
#

resource "random_integer" "sa_name" {
   min     = 1111
   max     = 9999  
  # Result will be like this - 1325
}

#
# - Create a Storage account with Network Rules
#

resource "azurerm_storage_account" "sa" {
    name                          =    "${var.saVars["name"]}${random_integer.sa_name.result}" 
    resource_group_name           =    azurerm_resource_group.rg.name
    location                      =    azurerm_resource_group.rg.location
    account_kind                  =    var.saVars["account_kind"]
    account_tier                  =    var.saVars["account_tier"]
    access_tier                   =    var.saVars["access_tier"]
    account_replication_type      =    var.saVars["account_replication_type"]

    static_website {
        index_document              = "index.html"
        error_404_document          = "404.html"
    }

    tags                          =   var.tags
}


resource "azurerm_storage_blob" "website" {
    for_each                      =     var.blobs
    name                          =     each.key
    storage_account_name          =     azurerm_storage_account.sa.name
    storage_container_name        =     "$web"
    type                          =     "Block"
    content_type                  =     "text/html"
    source                        =     each.value
}