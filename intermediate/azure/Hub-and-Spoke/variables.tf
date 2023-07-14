variable "resource_group_location" {
  type    = string
  default = "canadacentral"
}

variable "hub_resource_group_name" {
  type    = string
  default = "rg-hub-cc-001"
}

variable "spoke_resource_group_name" {
  type    = string
  default = "rg-spoke-cc-001"
}

variable "onprem_resource_group_name" {
  type    = string
  default = "rg-onprem-cc-001"
}

variable "hub_vnet_name" {
  type    = string
  default = "vnet-hub-cc-001"
}

variable "spoke_vnet_name_prefix" {
  type    = string
  default = "vnet-spoke-cc-"
}

variable "onprem_vnet_name" {
  type    = string
  default = "vnet-onprem-cc-001"
}

variable "hub_subnet_name" {
  type    = string
  default = "subnet-hub-cc-001"
}

variable "spoke_subnet_name_prefix" {
  type    = string
  default = "subnet-spoke-cc-"
}

variable "onprem_subnet_name" {
  type    = string
  default = "subnet-onprem-cc-001"
}

variable "hub_vm_name" {
  type    = string
  default = "vm-hub-cc-001"
}

variable "spoke_vm_name_prefix" {
  type    = string
  default = "vm-spoke-cc-"
}

variable "onprem_vm_name" {
  type    = string
  default = "vm-onprem-cc-001"
}

variable "spoke_count" {
  type    = number
  default = 2
}

variable "hub_nsg_name" {
  type    = string
  default = "nsg-hub-cc-001"
}

variable "hub_public_ip_name" {
  type    = string
  default = "pip-hub-cc-001"
}

variable "onprem_nsg_name" {
  type    = string
  default = "nsg-onprem-cc-001"
}

variable "onprem_public_ip_name" {
  type    = string
  default = "pip-onprem-cc-001"
}

variable "spoke_nsg_name_prefix" {
  type    = string
  default = "nsg-spoke-cc-"
}

variable "spoke_public_ip_name_prefix" {
  type    = string
  default = "pip-spoke-cc-"
}

variable "hub_nic_name" {
  type    = string
  default = "nic-hub-cc-001"
}

variable "onprem_nic_name" {
  type    = string
  default = "nic-onprem-cc-001"
}

variable "spoke_nic_name_prefix" {
  type    = string
  default = "nic-spoke-cc-"
}

variable "hub_storage_account_name" {
  type    = string
  default = "sthubcc001"
}

variable "onprem_storage_account_name" {
  type    = string
  default = "stonpremcc001"
}

variable "spoke_storage_account_name_prefix" {
  type    = string
  default = "stspokecc"
}