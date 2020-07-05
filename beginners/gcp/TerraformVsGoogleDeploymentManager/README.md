#### Terraform vs Google Deployment Manager

`Terraform` is a widely-used Public Cloud tool whereas `Google Deployment Manager` is only a GCP-native IaC tool.

Terraform:
1. Multi-Cloud Deployment: You can use terraform in all three major public cloud providers as AWS, Google Cloud and Azure.
2. Terraform uses HCL: This is HashiCorp's Configuration Language for creating IaC solutions for Cloud.
3. All Major Cloud Services are supported: All major cloud services are with Terraform and new major services are supported as soon as they are launched.

Google Deployment Manager:
1. Used on GCP Only: Deployment Manager is used for GCP services only, similar to ARM templates in Azure and CloudFormation in AWS.
2. You can Deploy Marketplace Solutions: User can use images from Google Cloud Marketplace to deploy with Deployment Manager.
3. You can use Python and Jinja2 Templates: Deployment Manager allows the use of Python and Jinja templates for configuration. This can allow the reuse of common deployments.

![Terraform vs Google Deployment Manager](/images/TerraformVsDeployMgr.jpg)
