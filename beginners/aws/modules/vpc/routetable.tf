resource "aws_route_table" "private" {
  vpc_id = aws_vpc.collabnix_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.collabnix_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}
