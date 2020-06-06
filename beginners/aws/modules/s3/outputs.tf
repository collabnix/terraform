output "bucket_domain_name" {
  value = aws_s3_bucket.my_static_website_bucket.website_endpoint
}

output "this_s3_bucket_bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
  value       = aws_s3_bucket.my_static_website_bucket.bucket_regional_domain_name
}
