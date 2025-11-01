output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = var.bucket_name
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  value       = var.table_name
}
