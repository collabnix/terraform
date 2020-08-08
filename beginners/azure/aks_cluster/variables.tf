#Variable
variable "client_id" {}

variable "client_secret" {}

variable "subscription_id" {}

variable "tenant_id" {}

variable "location" {}

variable "cluster_name" {}

variable "dns_prifix" {}

variable "resource_group_name" {}

variable "log_analytics_workspace_name" {}

variable "log_analytics_workspace_location" {
    default = "eastus"
}
variable "log_analytics_workspace_sku" {
    default = "PerNode"
}

