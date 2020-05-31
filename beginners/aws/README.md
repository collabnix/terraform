# Deploy your AWS EKS cluster with Terraform

The purpose of this tutorial is to create an EKS cluster with Terraform. Amazon Elastic Kubernetes Service (Amazon EKS) is a fully managed Kubernetes service by AWS. To go deeper you can read this article which explains another way to deploy an EKS cluster with eksctl.


## Pre-requisite:

- MacOS
- Get an AWS free trial account
- Install Terraform 0.11.7 

```
brew install terraform
```

- Install AWSCLI 2.0.17

```
brew install awscli
```

- Install AWS IAM Authenticator

```
brew install aws-iam-authenticator
```

- Install WGET

```
brew install wget
```

- Install Kubectl

```
brew install kubernetes-cli
```


## Setting up AWS IAM users for Terraform

The first thing to set up is your Terraform. We will create an AWS IAM users for Terraform.

In your AWS console, go to the IAM section and create a user named “FullAccess”. Then add your user to a group named “FullAccessGroup”. 
Attaches to this group the following rights:

- AdministratorAccess
- AmazonEKSClusterPolicy

After these steps, AWS will provide you a Secret Access Key and Access Key ID. 
Save them preciously because this will be the only time AWS gives it to you.

In your own console, create a ~/.aws/credentials file and put your credentials in it:


```
[default]
aws_access_key_id=***********
aws_secret_access_key=****************************
```

## Creating Config file

```
cat config
[default]
region=us-east-2
```

## Cloning the Repository

```
git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster
```

You can explore this repository by changing directories or navigating in your UI.

```
$ cd learn-terraform-provision-eks-cluster
```

In here, you will find six files used to provision a VPC, security groups and an EKS cluster. The final product should be similar to this:


- vpc.tf provisions a VPC, subnets and availability zones using the AWS VPC Module. A new VPC is created for this guide so it doesn't impact your existing cloud environment and resources.

- security-groups.tf provisions the security groups used by the EKS cluster.

- eks-cluster.tf provisions all the resources (AutoScaling Groups, etc...) required to set up an EKS cluster in the private subnets and bastion servers to access the cluster using the AWS EKS Module.

- On line 14, the AutoScaling group configuration contains three nodes.

- outputs.tf defines the output configuration.

- versions.tf sets the Terraform version to at least 0.12. It also sets versions for the providers used in this sample.
