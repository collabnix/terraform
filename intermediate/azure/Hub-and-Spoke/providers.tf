terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-demo-cc-001"
    storage_account_name = "stdemocc001"
    container_name       = "contdemocc001"
    key                  = "contdemocc001.tfstate"
  }
}

provider "azurerm" {
  features {}
}