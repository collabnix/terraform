variable "s3_bucket_name" {
   description =   "S3 Bucket Name"
   type        =   string
}

variable "aws_profile_name" {
   description =   "AWS Account profile name for local exec"
   type        =   string
}

variable "document_directory" {
   description =   "Directory where all S3 upload exist"
   type        =   string
}
