resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.privatesubnet.id

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
  depends_on = [aws_internet_gateway.igw]
}
