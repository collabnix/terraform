#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*   Storage account with Network Rules - Outputs      *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

output "storage_account_name" {
    description    =    "Name of the storage account"
    value          =    azurerm_storage_account.sa.name
}

output "website-url" {
    description    =    "URL of the static website"
    value          =    azurerm_storage_account.sa.primary_web_endpoint
}