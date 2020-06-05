## Create a Google compute instance in GCP

In this particular track, we are going to build a google cloud vpc using terrform.
We will be binding an instance of VPC with a subnet and firewall rules.

Add the necessary values of the variables in terraform.tfvars file or pass them as variables if you are using it as a module

```
vpc_name="<vpc-name>"
subnet_name="<subnet-name>"
gcp_project_id="<project-id>"
gcp_project_location="gcp-region"
ip_cidr_range="10.1.0.0/24"
ingress_ports=[80, 22, 8080]
```

### Terraform Init

This command will all the providers for you that are required to create your resource in GCP

```bash
cd vpc
terraform init
```

The CDN which servers the providers is quite slow that's why it can take some time for the providers to get downloaded

### Terraform plan

This command will layout a plan for you and show you what all resources can be created

```bash
cd vpc
terraform plan
```

### Terraform apply

This command will create all the mentioned resources for yor

```bash
cd vpc
terraform apply
```

You'll be prompted a confirmation - Press yes.

Once the resources have been created you should see

```
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

subnet_name = subnetes
vpc_name = vpcs
```
