## Create a Google compute instance in GCP

In this particular track, we are going to build a google compute instance using terrform.
We will be binding an instance with a static compute address and we'll also see how we can
attach service account/ scope on a virtual machine. We will also install a nginx server on our instance and we'll also allow traffic at Port 80 using http-server tags.

### Pre-requiste

In order to avoid explicitly using the GCP service key, we are going to use GOOGLE_APPLICATION_CREDENTIAL environment variable that points to our GCP service key.

1. Install Terraform ~> 0.12.26

2. If you have a service key at your disposal <br/>

   > export GOOGLE_APPLICATION_CREDENTIAL = {path to your service key file}

3. If you have not created a service account and a service key then follow below steps

   - Install gcloud cli
   - Run the following scripts

   ````bash
   export PROJECT_ID={Name of your GCP Project}

   export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/${PROJECT_ID}-terraform-admin.json

   gcloud iam service-accounts create terraform --display-name "Terraform admin account"

   gcloud projects add-iam-policy-binding ${PROJECT_ID} --member serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com   --role roles/owner

   gcloud services enable compute.googleapis.com

   gcloud services enable iam.googleapis.com

   gcloud iam service-accounts keys create ${GOOGLE_APPLICATION_CREDENTIALS} --iam-account terraform@${PROJECT_ID}.iam.gserviceaccount.com```
   ````

**Note** - you would need to export the GOOGLE_APPLICATION_CREDENTIALS every time you work with terraform when interacting with your configurations.

Add the necessary values of the variables in terraform.tfvars file

```
gcp_project_id="<project-id>"
gcp_project_location="<region>"
gcp_compute_zone="<zone>"
machine_type="<machine-type>"
```

### Terraform Init

This command will all the providers for you that are required to create your resource in GCP

```bash
cd virtual-machine
terraform init
```

The CDN which servers the providers is quite slow that's why it can take some time for the providers to get downloaded

### Terraform plan

This command will layout a plan for you and show you what all resources can be created

```bash
cd virtual-machine
terraform init
```

### Terraform apply

This command will create all the mentioned resources for yor

```bash
cd virtual-machine
terraform apply
```

You'll be prompted a confirmation - Press yes.

Once the resources have been created you should see

```
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

disk_name = disk-2a7c7a928746e7a6
instance_name = vm-2a7c7a928746e7a6
public_address = 34.87.216.228
```

Now if you will head over to the public address you should see nginx welcome page.
