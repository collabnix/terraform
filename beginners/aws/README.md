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

## Creating Provider.tf file

```
provider "aws" {
   profile    = "default"
   region     = "us-east-2"
 }
```

## Creating all Resource you require

