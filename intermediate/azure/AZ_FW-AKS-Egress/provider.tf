terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
}

provider "azurerm" {
  features {}

  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  subscription_id = ""
}