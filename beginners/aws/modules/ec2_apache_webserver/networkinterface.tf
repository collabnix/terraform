resource "aws_network_interface" "webserverNIC" {
  subnet_id = var.public_subnet
 
  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}
