# Terraform Beginners Track - Microsoft Azure

## Prerequisites

- Any Code Editor (Visual Studio Code or Atom etc) 
- Microsoft Azure Subscription. 

*Click [Here](https://azure.microsoft.com/en-in/free/search/?&OCID=AID2000081_SEM_XlDIrwAABVmA5our:20200530122244:s&msclkid=1115432c07451000abc21dfe5754b3b6&ef_id=XlDIrwAABVmA5our:20200530122244:s&dclid=CPHX0fPJ2-kCFYXQcwEd4G4KGA) to sign up for an account*

- Hashicorp Terraform installed and added to the PATH
- A Service Principal is created and given **Contributor** access
 

## Terraform

### Write the code

Write the terraform code to deploy a virtual network.

- main.tf - This file contains provider and resource blocks
- variables.tf - This file contains all the variables
- outputs.tf - This file contains the outputs that will be displayed in the console if the deployment is successful.

Note: These are the standard file names in terraform. You can use any name for a .tf file. Ex: vnet.tf, vars.tf etc.

> You can add the Service principal variables in **terraform.tfvars** file in the format shown below.

*client_id  = "CLIENTID-OF-THE-APP"\
client_secret  = "CLIENT-SECRET-OF-THE-APP"\
subscription_id  = "SUBSCRIPTIONID"\
tenant_id  = "TENANTID"*

**This is not a best practice. If you choose to do this, YOU MUST NOT CHECK THIS FILE INTO VERSION CONTROL. 
I would suggest you to add these as Environment variables. You can refer the terraform-azure authentication process documentation [here](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html)**

> You can also provide these credentials at the run time or you can supply the variables for terraform plan and terraform apply

- *$ terraform plan -var "client_id=CLIENT_ID" -var "client_secret=CLIENT_SECRET" -var "subscription_id=SUBSCRIPTION_ID" -var "tenant_id=TENANT_ID"

### Run the terraform commands shown below 


- *$ terraform init*
- *$ terraform validate*
- *$ terraform plan -out=vnet.tfplan*
- *$ terraform apply vnet.tfplan* 

> You have to manually type 'yes' to deploy the infrastructure. You can skip the manual intervention with the command **"terraform apply -auto-approve"**

Once the deployment is done and you have verified the resources in the azure portal, cleanup everything with below command.

- $ terraform destroy

> Again, you have to manually type 'yes' to destroy the infrastructure. You can skip the manual intervention with the command **"terraform destroy -auto-approve"**