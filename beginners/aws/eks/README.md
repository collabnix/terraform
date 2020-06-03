# Deploy your AWS EKS cluster with Terraform

The purpose of this tutorial is to create an EKS cluster with Terraform. Amazon Elastic Kubernetes Service (Amazon EKS) is a fully managed Kubernetes service by AWS. To go deeper you can read this article which explains another way to deploy an EKS cluster with eksctl.


## Pre-requisite:

- MacOS
- Get an AWS free trial account
- Install Terraform v0.12.26 

```
brew install terraform
```

If you're running Terraform 0.11, I would suggest to upgrade it to 0.12 ASAP.


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

In your AWS console, go to the IAM section and create a user named “SudoAccess”. Then add your user to a group named “SudoAccessGroup”. 
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

## Initialize Terraform workspace


```
[Captains-Bay]🚩 >  terraform init
Initializing modules...
Downloading terraform-aws-modules/eks/aws 12.0.0 for eks...
- eks in .terraform/modules/eks/terraform-aws-eks-12.0.0
- eks.node_groups in .terraform/modules/eks/terraform-aws-eks-12.0.0/modules/node_groups
Downloading terraform-aws-modules/vpc/aws 2.6.0 for vpc...
- vpc in .terraform/modules/vpc/terraform-aws-vpc-2.6.0

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "random" (hashicorp/random) 2.2.1...
- Downloading plugin for provider "local" (hashicorp/local) 1.4.0...
- Downloading plugin for provider "null" (hashicorp/null) 2.1.2...
- Downloading plugin for provider "kubernetes" (hashicorp/kubernetes) 1.11.3...
- Downloading plugin for provider "template" (hashicorp/template) 2.1.2...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.64.0...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[Captains-Bay]🚩 >
```

```
Apply complete! Resources: 51 added, 0 changed, 0 destroyed.

Outputs:

cluster_endpoint = https://83AEAE7D9A99A68DFA4162E18F4AD470.gr7.us-east-2.eks.amazonaws.com
cluster_name = training-eks-9Vir2IUu
cluster_security_group_id = sg-000e8af737c088047
kubectl_config = apiVersion: v1
preferences: {}
kind: Config

clusters:
- cluster:
    server: https://83AEAE7D9A99A68DFA4162E18F4AD470.gr7.us-east-2.eks.amazonaws.com
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJd01EVXpNVEV5TWpNME1Wb1hEVE13TURVeU9URXlNak0wTVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFXXXXXXXXXXXXcEN2c1ZmanlkYmYxdGVmV0hXRXhsZ1prL01TSEt4R3BWdGthTFFvZ0NUVE51dzV1SzZNQ2FBM3FoeVNOTXMKc1pLVGMxSXhRQnNWdFVvZjRPNHhGZnd0aHM0Vk9zVEZmSEY4bHdnSnpwWEVEanlhRTJ1MnV4OHVnUnN1Y3RhMQpNWkFneVVBS1hma1pQV2d4OXBWdWFOMHkzeE02ZTdTaUtYNFpTNmhFQzcyK1hrK29Na2tsSlFlQ0J3TT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
  name: eks_training-eks-9Vir2IUu

contexts:
- context:
    cluster: eks_training-eks-9Vir2IUu
    user: eks_training-eks-9Vir2IUu
  name: eks_training-eks-9Vir2IUu

current-context: eks_training-eks-9Vir2IUu

users:
- name: eks_training-eks-9Vir2IUu
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "training-eks-9Vir2IUu"
region = us-east-2
```

## Configure kubectl

Now that you've provisioned your EKS cluster, you need to configure kubectl. Customize the following command with your cluster name and region, the values from Terraform's output. It will get the access credentials for your cluster and automatically configure kubectl.


```
aws eks --region us-east-2 update-kubeconfig --name training-eks-9Vir2IUu
```

```
Added new context arn:aws:eks:us-east-2:125346028423:cluster/training-eks-9Vir2IUu to /Users/ajeetraina/.kube/
```


## Troubleshooting:

If you are facing the below error message while running ```terraform init```:

```
[Captains-Bay]🚩 >  terraform validate

Error: Error parsing /Users/ajeetraina/.aws/learn-terraform-provision-eks-cluster/eks-cluster.tf: At 3:18: Unknown token: 3:18 IDENT local.cluster_name
```

Then to fix it , you need to update your Terraform version by running

```
brew upgrade terraform
```





