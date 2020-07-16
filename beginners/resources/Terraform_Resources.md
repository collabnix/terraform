# Terraform Resources
## Component or Object
Terraform has two different type of component/object
- `resource`
- `data`

### Resource:
Resource are the daily bread of Terraform. They illustrate the infrastructure pieces that you want to manage such as networks, servers, firewalls, etc. Terraform will use the cloud provider APIs to perform the create, read, update, and delete(CRUD) operations. The `resource` object is constructed of a provider-name_resource-type, local identifier and the block containing the configuration of the resource. This would be better understood with the below diagram.

<p align="center">
<img src="https://github.com/Raviadonis/terraform-1/blob/master/images/Terraform_Resource_definition.png" width="640">
</p>

All the resources are linked to a provider. From the above diagram, **`aws_instance`** indicates that this resource type is provided by the `aws` provider. Next is the local identifier name for the resource, which is specified by you, here we have named as `web` so that we can reference it elsewhere and Terraform keep track of it in the `.tfstate` file. Concept of `state` file will be covered in the upcoming tracks.

See the below example code for the resource creation and how it is referenced to another piece of resource block.

```hcl
resource "aws_instance" "collabnix_node" {
 ami               = "ami-21f78e11"
 availability_zone = var.availability_zone
 instance_type     = var.instance_type

 tags {
   Name = "Collabnix_terraform"
 }
}

resource "aws_ebs_volume" "collabnix_vol" {
 availability_zone = "us-east-1c"
 size              = 1

  tags {
   Name = "Collabnix_terraform_vol"
 }
}

resource "aws_volume_attachment" "collabnix_vol_attachment" {
 device_name = "/dev/sdh"
 volume_id   = aws_ebs_volume.collabnix_vol.id
 instance_id = aws_instance.collabnix_node.id
}
```

From the above, we are creating a single EC2 instance, EBS volume, and attaching that volume to the instance. The first two resource blocks (EC2 instance & EBS volume) will be created independently. While trying to attach the volume to the instance, Terraform requires IDs of instance and volume to be attached. In this case you need to refer the local identifier name and the required attributes of the resources. See the below diagram for better understanding:

<p align="center">
<img src="https://github.com/Raviadonis/terraform-1/blob/master/images/Terraform_Resource_Identifier.png" width="640">
</p>

Now terraform has enough information to take the necessary action. Here the `id` attributes are accessed using the dot-separated notation, like `aws_instance.collabnix_node.id`. Each type of resource will export thier own set of attribute values. Here, for example we used the `id` attribute. Refer this link for more details ([Attribute reference](https://www.terraform.io/docs/providers/aws/r/instance.html#attributes-reference))

### Data sources:
These are very similar to regular [resource](https://github.com/Raviadonis/terraform-1/blob/master/beginners/resources/README.md#resource) object which represents a piece of read-only information that can be fetched from the `provider` (here it is AWS) or from an [external](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source) data source. This cannot be used for any operations like CREATE, UPDATE, or DELETE. Instead, they can only return several informations (meta-data) like AMI ID, Private IP, Instance ID and so on from an existing resources.

```hcl
data "aws_ami" "app-ami" { 
  most_recent = true 
  owners = ["self"] 
} 
 
resource "aws_instance" "community" {
  ami           = data.aws_ami.app-ami.id
  instance_type = "t2.micro"
  tags = {
    Name = "Collabnix"
  }
}
```
From the above example code, we are creating an EC2 instance by using the existing AMI ID. Let's assume we have already created an AMI manually or with a different set of tools like `Packer`. Now terraform needs AMI-ID to create an instance and it fetches the ID from the data source `app-ami`.

**Note:**
The combination of resource type and the local identifier name must be unique in your configuration. The below configuration 
will through an error like:
`aws_instance.collabnix_node: resource repeated multiple times`

```hcl
resource "aws_instance" "collabnix_node" {
 ami               = "ami-21f78e11"
 instance_type     = var.instance_type
}

resource "aws_instance" "collabnix_node" {
 ami               = "ami-21f78e11"
 instance_type     = var.instance_type
}
```

## Arguments

This is just a syntax of assining the vaules within the configuration blocks. It looks like the below
```hcl
resource "aws_instance" "collabnix_node" {
 ami               = "ami-21f78e11"          # <IDENTIFIER> = <EXPRESSION>
 instance_type     = var.instance_type
}
```
Each type of resources will have the list of supported arguments (required and optional) you can consume within your configuration blocks.

Morover, you can also use the special kind of arguments called [meta-arguments](https://www.terraform.io/docs/configuration/resources.html#meta-arguments) within any type of resource. Primarily, these meta-arguments are used to change the behavior of the resource. See the list of meta-arguments below
- `depends_on`
- `count`
- `for_each`
- `provider`
- `lifecycle`
- `provisioner`
- `connection`

```hcl
resource "aws_instance" "collabnix_node" {
  depends_on        = [aws_s3_bucket.collabnix_bucket]
  count             = 2
  ami               = "ami-21f78e11"
  instance_type     = var.instance_type
}

resource "aws_s3_bucket" "collabnix_bucket" {
  bucket = "lab-bucket"
  acl = "private"
  versioning {
    enabled = true
  }
  tags {
    Name = "test-s3-terraform-bucket"
  }
}
```
The above configuration blocks are just an example of how the meta-arguments can be used. Please do not go deeper and try to understand how it works in this beginner track.
