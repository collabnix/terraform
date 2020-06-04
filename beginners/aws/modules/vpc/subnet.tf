resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.collabnix_vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = "true"

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}

resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.collabnix_vpc.id
  cidr_block =  var.private_subnet_cidr

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}
