resource "aws_route_table" "route" {
  vpc_id = aws_vpc.collabnix_vpc.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    cidr_block = "10.0.2.0/24"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}
