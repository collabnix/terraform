resource "aws_vpc" "collabnix_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "dedicated"

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}
