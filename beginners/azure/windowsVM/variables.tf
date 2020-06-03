#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Windows 10 VM - Variables
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

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
    description =   "Tenant I   D"
    type        =   string
}

# Prefix and Tags

variable "prefix" {
    description =   "Prefix to append to all resource names"
    type        =   string
    default     =   "collabnix"
}

variable "tags" {
    description =   "Resouce tags"
    type        =   map(string)
    default     =   {
        "project"       =   "Collabnix"
        "deployed_with" =   "Terraform"
    }
}

# Resource Group

variable "location" {
    description =   "Location of the resource group"
    type        =   string
    default     =   "East US"
}

# Vnet and Subnet

variable "vnet_address_range" {
    description =   "IP Range of the virtual network"
    type        =   string
    default     =   "10.0.0.0/16"
}

variable "subnet_address_range" {
    description =   "IP Range of the virtual network"
    type        =   string
    default     =   "10.0.1.0/24"
}

# Public IP and NIC Allocation Method

variable "allocation_method" {
    description =   "Allocation method for Public IP Address and NIC Private ip address"
    type        =   list(string)
    default     =   ["Static", "Dynamic"]
}


# VM 

variable "virtual_machine_size" {
    description =   "Size of the VM"
    type        =   string
    default     =   "Standard_B1s"
}

variable "computer_name" {
    description =   "Computer name"
    type        =   string
    default     =   "Win10vm"
}

variable "admin_username" {
    description =   "Username to login to the VM"
    type        =   string
    default     =   "winadmin"
}

variable "admin_password" {
    description =   "Password to login to the VM"
    type        =   string
    default     =   "P@$$w0rD2020*"
}

variable "os_disk_caching" {
    default     =       "ReadWrite"
}

variable "os_disk_storage_account_type" {
    default     =       "StandardSSD_LRS"
}

variable "os_disk_size_gb" {
    default     =       128
}

variable "publisher" {
    default         =       "MicrosoftWindowsDesktop"
}

variable "offer" {
    default         =       "Windows-10"
}

variable "sku" {
    default         =       "rs5-pro"
}

variable "vm_image_version" {
    default         =       "latest"
}
