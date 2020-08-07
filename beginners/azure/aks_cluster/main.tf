/*
*Author - Kasun Rajapakse
*Subject -  Create AKS Cluster
*Language - HCL
*/

#Add Azure Provider
provider "azurerm" {

    version         =   "~>2.0"
    client_id       =   var.client_id
    client_secret   =   var.client_secret
    subscription_id =   var.subscription_id
    tenant_id       =   var.tenant_id
    features {}
}

resource "random_string" "log_analytics_sufix" {
    length = 5
    lower = true
    special = false
    number = false
}

#Create Resource Group
resource "azurerm_resource_group" "k8terraform" {
    name = var.resource_group_name
    location = var.location
}

#Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "aksterraform" {
    name                = "${var.log_analytics_workspace_name}-${random_string.log_analytics_sufix.result}"
    location            = var.log_analytics_workspace_location
    resource_group_name = azurerm_resource_group.k8terraform.name
    sku                 = var.log_analytics_workspace_sku
}

#Enable Log Analytics Solution
resource "azurerm_log_analytics_solution" "aksterraformsolution" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.aksterraform.location
    resource_group_name   = azurerm_resource_group.k8terraform.name
    workspace_resource_id = azurerm_log_analytics_workspace.aksterraform.id
    workspace_name        = azurerm_log_analytics_workspace.aksterraform.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

#Create AKS Cluster
resource "azurerm_kubernetes_cluster" "k8cluster" {
    name = var.cluster_name
    location = azurerm_resource_group.k8terraform.location
    resource_group_name = azurerm_resource_group.k8terraform.name
    dns_prefix = var.dns_prifix

    default_node_pool {
        name = "infrapool"
        vm_size = "Standard_D2_v2"
        max_pods = 50
        node_count = 3
    }

    addon_profile{
        oms_agent{
            enabled = true
            log_analytics_workspace_id = azurerm_log_analytics_workspace.aksterraform.id
        }
    }

    identity {
        type = "SystemAssigned"
    }

    tags ={
        Enviornment = "Development"
    }
}

