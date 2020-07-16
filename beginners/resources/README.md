# Terraform Resources

Resource are the daily bread of Terraform. They illustrate the infrastructure pieces that you want to manage such as networks, servers, firewalls, etc. The `resource` object is constructed of a provider-name_resource-type, local identifier and the block containing the configuration of the resource. This would be better understood with the below diagram.
![Resource definition](https://github.com/Raviadonis/terraform-1/blob/master/images/Terraform_Resource_definition.png | width=100px)
All the resources are linked to a provider. From the above diagram, **`aws_instance`** indicates that this resource type is provided by the `aws` provider. Next is the local identifier name for the resource, which is specified by you, here we have named as `web` so that we can reference it elsewhere and Terraform keep track of it in the `.tfstate` file. Concept of `state` file will be covered in the upcoming tracks.

See the below example code for the resource creation and how it is referenced to another piece of resource block.

```hcl
resource "aws_instance" "collabnix_node" {
 ami               = "ami-21f78e11"
 availability_zone = "${var.availability_zone}"
 instance_type     = "${var.instance_type}"

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
![TF_Resource_Identifier.png](https://github.com/Raviadonis/terraform-1/blob/master/images/Terraform_Resource_Identifier.png)
Now terraform has enough information to take the necessary action. Here the `id` attributes are accessed using the dot-separated notation, like `aws_instance.collabnix_node.id`.
