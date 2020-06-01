resource "aws_eip" "nat_eip" {
  vpc = true
  depends_on = [aws_internet_gateway.igw]
}
