resource "aws_s3_bucket" "my_static_website_bucket" {
  bucket = var.s3_bucket_name
  acl    = "public-read"
  force_destroy = true

  tags = {
    project = "Collabnix"
    department = "Automation"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
  provisioner "local-exec" {
     command = "aws s3 cp ${var.document_directory} s3://${var.s3_bucket_name}/ --exclude \"*\" --include \"*.html\" --recursive --profile ${var.aws_profile_name} --acl public-read"
  }

}
