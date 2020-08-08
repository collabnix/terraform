# Create a AKS Cluster with Container Monitoring enabled using Azure Terraform

**This module creates a 3 node Linux AKS Cluster**

> Note 1: This deployment is not free. If you are not on a free trail, it will incur a very small fee. So, its always a good practice to cleanup everything when you are done with the demo.

> Note 2: We are creating a public IP address and attaching it to the AKS Cluster Load balancer.
## Resources in this module

- A Resource Group
- A Virtual network with a Subnet
- A Network Security Group
- Subnet and NSG Association
- A Public IP Address
- AKS Cluster
- Route Tabels
- Log Analytics Workspace
- Container Monitoring Solution for Log Analytics

> Notice that in this module, we are using a **Sufix** variable. We can use it to append to all resources for names.

> Note 1 - This output the cluster key, certificate and the passwords 

## Prerequisites

Click [Here](https://github.com/collabnix/terraform/blob/master/beginners/azure/README.md) to know the process of initial set up.

## Steps

- *$ cd beginners/azure/aks_cluster* 

> Make sure you are in this directory. This is the directory from where we run terraform commands.

## After the deployment

- Once the deployment is successful, you can use **az login** to authenticate to subscription and use **az aks get-credentials** command with proper parameters to download the cluster credentials.

- Cleanup everything with **$ terraform destroy -auto-approve**
