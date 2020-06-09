# Create a Virtual Network in Azure with Terraform using Module

**This module creates a virtual network with a subnet.**

## Prerequisites: 

Click [Here](https://github.com/collabnix/terraform/blob/master/beginners/azure/README.md) to know the process of initial set up.

## Steps:

- *$ cd beginners/azure/module_example* 

> Make sure you are in this directory. This is the directory from where we run terraform commands.

- In this directory, we have a folder called child_module. The child_module folder has all the resources to deploy a virtual network. So, instead of running terraform commands inside the child_module, we have modularized the virtual network deployment and calling it from the root module. This will enable us to reuse the configuration.

- In the **module "vnet"** block, I have hardcoded all the values. You can also put variables in module block and assign the values in variables.tf

- If you want to know and learn more about modules, click [here](https://www.terraform.io/docs/configuration/modules.html)



