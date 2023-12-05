output "bucket_id" {
  value       = aws_s3_bucket.khu-bucket.id
  description = "The name of the bucket."
}

output "bucket_arn" {
  value       = aws_s3_bucket.khu-bucket.arn
  description = "The ARN of the bucket."
}

output "bucket_domain_name" {
  value = aws_s3_bucket.khu-bucket.bucket_domain_name
}