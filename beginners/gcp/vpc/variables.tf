variable "gcp_project_id" {
  description = "This is a GCP Project id"
  type        = string
}

variable "gcp_project_location" {
  description = "This is a GCP Project id"
  type        = string
}

variable "ip_cidr_range" {
  description = "This is the cidr range for subnet"
  type        = string
}

variable "ingress_ports" {
  description = "This is the list of ports for vpc"
  type        = list(string)
}

variable "subnet_name" {
  description = "This is the name that subnet gets"
  type        = string
}

variable "vpc_name" {
  description = "This is the name that vpc gets"
  type        = string
}
