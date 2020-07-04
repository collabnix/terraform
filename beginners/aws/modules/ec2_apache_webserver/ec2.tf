data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.key_pair_name

  network_interface {
    network_interface_id = aws_network_interface.webserverNIC.id
    device_index         = 0
  }

  provisioner "file" {

    connection {
      host = self.public_ip
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("${path.module}/key.pem")
    }

    source      = var.bootscript_file_path
    destination = "/tmp/bootscript.sh"
  }

  provisioner "remote-exec" {

    connection {
      host = self.public_ip
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("${path.module}/key.pem")
    }
    inline = [
      "chmod +x /tmp/bootscript.sh",
      "/tmp/bootscript.sh",
    ]
  }

  tags = {
    project = "Collabnix"
    department = "Automation"
  }
}
