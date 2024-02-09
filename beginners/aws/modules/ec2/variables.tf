variable "public_subnet" {}

variable "key_pair_name" {
   description =   "Key_Pair_Name"
   type        =   string
   default = "keypair"
}

variable "instance_type" {
   default = "t2.micro"
}
