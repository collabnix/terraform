# Create a Windows 10 Virtual Machine in Azure with Terraform

**This module creates a Windows virtual machine (Windows 10 Pro)**

> Note 1: This deployment is not free. If you are not on a free trail, it will incur a very small fee. So, its always a good practice to cleanup everything when you are done with the demo.

> Note 2: We are creating a public IP address and attaching it to the VM to login via RDP. This is not a best practice and not recommended at all in a real production environment. So, please destroy the infrastructure after the demo. 

## Resources in this module

- A Resource Group
- A Virtual network with a Subnet
- A Network Security Group
- Subnet and NSG Association
- A Public IP Address
- A Network Interface
- A Windows Virtual Machine

> Notice that in this module, we are using a **Prefix** variable. We can use it to append to all resources for names.

## Prerequisites

Click [Here](https://github.com/collabnix/terraform/blob/master/beginners/azure/README.md) to know the process of initial set up.

## Steps

- *$ cd beginners/azure/windowsVM* 

> Make sure you are in this directory. This is the directory from where we run terraform commands.

## Changes you need to make before execution

- In **azurerm_network_security_group** resource, paste in your local IP Address in *source_address_prefix*. This will restrict SSH access to your machine. Click [here](https://www.whatsmyip.org/) to findout your local ip address.

## After the deployment

- Once the deployment is successful, you can login to the virtual machine. Login to the portal, go to the VM and click on Connect and select RDP.
- Download the RDP file. If you are on Windows, you can connect to the VM using Remote Desktop. If you are on Mac, download and install "Microsoft Remote Desktop" application from the appstore.

- Cleanup everything with **$ terraform destroy -auto-approve**
