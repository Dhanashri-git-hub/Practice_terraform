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
output "vpc_id" {
  description = "ID of the custom VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}

output "server_private_ip" {
  description = "Private IP of the server (it has no public IP)"
  value       = aws_instance.server.private_ip
}