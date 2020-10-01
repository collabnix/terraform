terraform{
backend "s3" {
bucket = "s3bucketName" // s3 bucket name created from AWS console
key = "terraform.tfstate" // terraform state file
region = "" // provide s3 bucket region
}
}
