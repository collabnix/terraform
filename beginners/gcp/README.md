# How to setup Terraform for  Google Cloud Engine


### Pre-requiste

In order to avoid explicitly using the GCP service key, we are going to use GOOGLE_APPLICATION_CREDENTIAL environment variable that points to our GCP service key.

## Installing Terraform ~> 0.12.26

If you have a service key at your disposal <br/>

   ```
   export GOOGLE_APPLICATION_CREDENTIAL = {path to your service key file}
   ```

If you have not created a service account and a service key then follow below steps

 ## Install gcloud cli

The gcloud cli is a part of [Google Cloud SDK](https://cloud.google.com/sdk/docs). We must download and install the SDK on your system and initialize it before you can use the gcloud command-line tool. 

Note: You can follow the install script given in the Google Cloud SDK documentation.

## Google Cloud SDK Quickstart script for CentOS

   ```
   sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
   [google-cloud-sdk]
   name=Google Cloud SDK
   baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
   enabled=1
   gpgcheck=1
   repo_gpgcheck=1
   gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
          https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
   EOM
   ```

 ## Installing Google cloud SDK 

   ```
   yum install google-cloud-sdk
   ```

 Once the SDK is installed, run gcloud init to initialize the SDK,

   ```
   gcloud init
   ```

  ## Run the following scripts

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
