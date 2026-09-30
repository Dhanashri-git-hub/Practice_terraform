output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.server.id
}

output "bucket_name" {
  description = "Name of the S3 log bucket"
  value       = aws_s3_bucket.logs.bucket
}
output "role_name" {
  description = "IAM role attached to the EC2 instance"
  value       = aws_iam_role.server.name
}