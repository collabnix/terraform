#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*  Create a Virtual Network in Azure - Variables    *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

# Service Principal Variables

variable "client_id" {
    description =   "Client ID (APP ID) of the application"
    type        =   string
}

variable "client_secret" {
    description =   "Client Secret (Password) of the application"
    type        =   string
}

variable "subscription_id" {
    description =   "Subscription ID"
    type        =   string
}

variable "tenant_id" {
    description =   "Tenant ID"
    type        =   string
}

# Resource Group Variables

variable "resource_group_name" {
    description =   "Name of the resource group"
    type        =   string
    default     =   "Collabnix-RG"
}

variable "location" {
    description =   "Location of the resource group"
    type        =   string
    default     =   "East US"
}

variable "virtual_network_name" {
    description =   "Name of the virtual network"
    type        =   string
    default     =   "Collabnix-Vnet"
}

variable "vnet_address_range" {
    description =   "IP Range of the virtual network"
    type        =   string
    default     =   "10.0.0.0/16"
}

variable "subnet_name" {
    description =   "Name of the subnet"
    type        =   string
    default     =   "Webserver-Subnet"
}

variable "subnet_address_range" {
    description =   "IP Range of the virtual network"
    type        =   string
    default     =   "10.0.1.0/24"
}