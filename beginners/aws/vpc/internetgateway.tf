resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.collabnix_vpc.id

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}
