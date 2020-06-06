# Create a Static Website on AWS S3 account with Terraform

**This module creates a S3 Bucket and hosts a static website**

> Note 1: This deployment is not free. If you are not on a free trail, it will incur a very small fee. So, its always a good practice to cleanup everything when you are done with the demo.


## Prerequisites

AWS Account

## Start this module


> Make sure you are in directory outside modules and running terraform command as the user who has AWS s3 CLI permissions.
> Please change below attributes as per your requirements s3_bucket_name, document_directory and aws_profile_name(this is AWS credentials profile name) in module section.
> This will create S3 bucket and followed by it will upload sample HTML files into the bucket.
> Execute above command sudo **$ sudo terraform apply -target module.collabnix_static_s3_website -auto-approve**
- After the  S3 bucket created, copy the url from the output, paste it in a browser. You should see the below page



![Success](https://github.com/collabnix/terraform/blob/master/images/aws_website_success.png)

- If you want to see the error page, append /error to the url.



![Error](https://github.com/collabnix/terraform/blob/master/images/aws_website_error.png)


## After the deployment

- Cleanup everything with **$ sudo terraform destroy -target module.collabnix_static_s3_website -auto-approve**
