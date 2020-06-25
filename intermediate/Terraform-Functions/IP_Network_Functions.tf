#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#
#*  Terraform Functions - IP Network Functions   *#
#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#

#--------------------------------------------------------------------------------------------------------------------
# cidrsubnet()
# Calculates a subnet address within given IP network address prefix. 
# Syntax: cidrsubnet(prefix, newbits, netnum)
# More Info at https://www.terraform.io/docs/configuration/functions/cidrsubnet.html
#--------------------------------------------------------------------------------------------------------------------

variable "vpc-cidr" {
    description     =   "Address range of Aws VPC/Azure Vnet"
    type            =   string
    default         =   "10.0.0.0/16"
}

output "cidrsubnet-output" {
    description =   "Print the output of cidrsubnet function"
    value       =   {
        "Web-Subnet"        =   cidrsubnet(var.vpc-cidr, 8, 1)
        "App-Subnet"        =   cidrsubnet(var.vpc-cidr, 8, 2)
        "DB-Subnet"         =   cidrsubnet(var.vpc-cidr, 8, 3)
    }
}

#--------------------------------------------------------------------------------------------------------------------
# cidrsubnets()
# Calculates a sequence of consecutive IP address ranges within a particular CIDR prefix.
# Syntax: cidrsubnets(prefix, newbits...)
# More Info at https://www.terraform.io/docs/configuration/functions/cidrsubnets.html
#--------------------------------------------------------------------------------------------------------------------

output "cidrsubnets-output" {
    description =   "Print the output of cidrsubnets function"
    value       =   {
        "Dev-Subnets"   =   cidrsubnets(var.vpc-cidr, 8, 8, 8, 8)
        "Prod-Subnets"  =   cidrsubnets(var.vpc-cidr, 4, 4, 8, 4)
    }
}

#--------------------------------------------------------------------------------------------------------------------
# cidrhost()
# Calculates a full host IP address for a given host number within a given IP network address prefix.
# Syntax: cidrhost(prefix, hostnum)
# More Info at https://www.terraform.io/docs/configuration/functions/cidrhost.html
#--------------------------------------------------------------------------------------------------------------------

output "cidrhost-output" {
    description =   "Print the output of cidrhost function"
    value       =   {
        "IP1"        =   cidrhost(var.vpc-cidr, 8)
        "IP2"        =   cidrhost(var.vpc-cidr, 256)
        "IP3"        =   cidrhost(var.vpc-cidr, 268)
    }
}