variable "cidr_block" {
  description =   "CIDR range for your VPC"
  type        =   string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description =   "CIDR range for your public Subnet"
  type        =   string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description =   "CIDR range for your private Subnet"
  type        =   string
  default = "10.0.2.0/24"
}
