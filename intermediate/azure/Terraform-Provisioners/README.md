# Terraform Provisioners example

- [Terraform Provisioners Official Documentation](https://www.terraform.io/docs/provisioners/index.html)

- **Local-Exec Provisioner** - The local-exec provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform, not on the resource. 

- **Remote-Exec Provisioner** - The remote-exec provisioner invokes a script on a remote resource after it is created. This can be used to run a configuration management tool, bootstrap into a cluster, etc. The remote-exec provisioner supports both ssh and winrm type connections.


**This module creates a linux virtual machine (UBUNTU 16.04)**

> Note 1: This deployment is not free. If you are not on a free trail, it will incur a very small fee. So, its always a good practice to cleanup everything when you are done with the demo.

> Note 2: We are creating a public IP address and attaching it to the VM to login via SSH. This is not a best practice and not recommended at all in a real production environment. So, please destroy the infrastructure after the demo. 

## Changes you need to make before execution

- In **azurerm_network_security_group** resource, paste in your local IP Address in *source_address_prefix*. This will restrict SSH access to your machine. Click [here](https://www.whatsmyip.org/) to findout your local ip address.

## Resources in this module

- A Resource Group
- A Virtual network with a Subnet
- A Network Security Group
- Subnet and NSG Association
- A Public IP Address
- A Network Interface
- A Linux Virtual Machine - (Local-exec and Remote-exec provisioners)

## Provisioners Run


![Provisioners-Run](https://github.com/collabnix/terraform/blob/master/images/Terraform-Provisioners.png)

## After the deployment

- Once the deployment is successful, you can login to the virtual machine. Login to the portal, go to the VM and click on Connect and select SSH.

> DO NOT FORGET to cleanup everything with  **$ terraform destroy -auto-approve**

