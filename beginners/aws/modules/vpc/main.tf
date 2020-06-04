resource "aws_vpc" "collabnix_vpc" {
  cidr_block       = var.cidr_block

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}
