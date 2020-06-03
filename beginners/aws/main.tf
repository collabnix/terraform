module "collabnix_vpc" {
  source = "./modules/vpc"
}

module "collabnix_ec2" {
  source = "./modules/ec2"
  public_subnet = module.collabnix_vpc.public_subnet_id
}
