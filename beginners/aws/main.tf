module "collabnix_vpc" {
  source = "./modules/vpc"
}

module "collabnix_ec2" {
  source = "./modules/ec2"
  public_subnet = module.collabnix_vpc.public_subnet_id
}

module "collabnix_ec2_webserver" {
  source = "./modules/ec2_apache_webserver"
  public_subnet = module.collabnix_vpc.public_subnet_id
}

module "collabnix_static_s3_website" {
  source = "./modules/s3"
  s3_bucket_name = "my-collabnix-test-bucket-name.com"
  aws_profile_name = "{profile_name}"
  document_directory = "./modules/s3/"
}
  
module "collabnix_application_load_balancer" {
  source = "./modules/application_load_balancer"
}
  
module "collabnix_API_Gateway_Cloudwatch" {
  source = "./modules/API_Gateway & Cloudwatch"
}
  
  
