#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*    Create multiple resources using for_each         *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#


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

variable "tags" {
    description     =   "Tags"
    type            =   map(string)
    default         =   {
        "Project"       =   "Collabnix"
        "Deployed_with" =   "Terraform"
        "Track"         =   "Beginner"
    }
}

#
# - Resource Group Variables
#

variable "resource_group" {
    description     =       "Create multiple resource groups"
    type            =       map(string)
    default         =       {
        "Dev-RG"        =       "South India"
        "QA-RG"         =       "West India"
        "Prod-RG"       =       "Central India"
    }
}

#
# - Virtual Network Variables
#

variable "virtual_network" {
    description     =       "Virtual Network variables"
    type            =       map(string)
    default         =       {
        "name"              =       "Dev-Vnet"
        "address_range"     =       "10.0.0.0/16"
    }
}

#
# - Subnet Variables
#

variable "subnet" {
    description     =       "Create multiple subnets"
    type            =       map(string)
    default         =       {
        "Web-Subnet"    =       "10.0.1.0/24"
        "App-Subnet"    =       "10.0.2.0/24"
        "DB-Subnet"     =       "10.0.3.0/24"
    }
}