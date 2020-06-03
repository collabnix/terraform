# Create a Static Website on Azure Storage account with Terraform

**This module creates a Storage account in Azure and hosts a static website**

> Note 1: This deployment is not free. If you are not on a free trail, it will incur a very small fee. So, its always a good practice to cleanup everything when you are done with the demo.

## Resources in this module

- A Resource Group
- A Storage Account

## Prerequisites

Click [Here](https://github.com/collabnix/terraform/blob/master/beginners/azure/README.md) to know the process of initial set up.

## Steps

- *$ cd beginners/azure/storageAccount* 

> Make sure you are in this directory. This is the directory from where we run terraform commands.

- After the storage account is created, copy the url from the output, paste it in a browser. You should see the below page



![Success](https://github.com/collabnix/terraform/blob/master/images/Azure_staticwebsite_Success.png)

- If you want to see the error page, append /error to the url.



![Error](https://github.com/collabnix/terraform/blob/master/images/Azure_staticwebsite_Error.png)


## After the deployment

- Cleanup everything with **$ terraform destroy -auto-approve**
