# Terraform Providers
In general, providers that are implemented as plugins(single binary) and the plugins/providers are the things that talk to the upstream APIs to make changes to the real infrastructure. Terraform uses a single provider, or multiple providers, to establish a connection to any services like IaaS, PaaS, or SaaS and provision resources. The provider is the first thing you need to set up before you can start creating resources for the vendor the provider is designed for.

We will take infrastructure provider AWS as an example here. The AWS provider is designed to allow you to provision AWS resources, such as EC2 Instances or Security groups, against your AWS account. Without first declaring the provider, Terraform does not know about your account details, region, the security profile to use, and so on.

Terraform’s documentation on providers can be found here:

[Providers](https://www.terraform.io/docs/providers/index.html)

## AWS Provider
We will focus on AWS for example. We’ll need to configure an AWS provider with our region, at minimum.
A simple version of the AWS provider looks like this:

```hcl
provider "aws" {
  region = "ap-south-1"
}
```
The above code block is sufficient, if you have configured your AWS credentials locally ([Refer this link for more details](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)).

AWS provider offers a different ways of passing credentials for authentication as below

- Static credentials
- Environment variables
- Shared credentials file
- EC2 Role (Will be covered in advanced track)

### Static credentials
> **WARNING:** This is one of the supported method for authentication, but hard-coding is strictly NOT recommended.

Using this method, you can pass the AWS **access_key** ID and **secret_key** within the provider code block as an argument.

```hcl
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAXXXXXMPLE"
  secret_key = "wJalrXUtnXXXXXXXXKEY"
}
```

### Environment variables
This method provide another way to specify configuration options and credentials. The following examples show how you can configure environment variables for the default user.

```hcl
provider "aws" {}
```

**Linux or Mac:**
```bash
export AWS_ACCESS_KEY_ID=AKIAXXXXXMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnXXXXXXXXKEY
export AWS_DEFAULT_REGION=ap-south-1
```

**Windows PowerShell:**
```powershell
$Env:AWS_ACCESS_KEY_ID="AKIAXXXXXMPLE"
$Env:AWS_SECRET_ACCESS_KEY="wJalrXUtnXXXXXXXXKEY"
$Env:AWS_DEFAULT_REGION="ap-south-1"
```
Once you have exported the keys, you can run the terraform commands.


### Shared credentials file
If you have [configured AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) on your system earlier, credentials and default region informations will be stored in a plain-text under the default location of user's home directory `$HOME/.aws/credentials`. Terraform will check this location for the credentials. Optionally you can specify a different custom location by providing the `shared_credentials_file` argument

```hcl
provider "aws" {
  region                  = "ap-south-1"
  shared_credentials_file = "/home/tf_user/creds"
}
```
