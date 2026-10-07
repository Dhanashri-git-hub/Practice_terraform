# Find the latest AMI 
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# S3 bucket names must be globally unique, so add a random suffix
resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "logs" {
  bucket = "${var.project_name}-logs-${random_id.suffix.hex}"

  tags = {
    Name    = "${var.project_name}-logs"
    Project = var.project_name
  }
}

# Make sure the bucket can never be made public
resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_instance" "server" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.server.name
  subnet_id                   = aws_subnet.private.id          # new
  vpc_security_group_ids      = [aws_security_group.server.id] # new
  associate_public_ip_address = false                          # new


  # Require IMDSv2 (the more secure way for the instance to fetch its credentials)
  metadata_options {
    http_tokens = "required"
  }

  # Runs once on first boot: proves the role works by writing a file to S3
  user_data = <<-EOF
    #!/bin/bash
    echo "Hello from $(hostname) at $(date)" > /tmp/hello.txt
    aws s3 cp /tmp/hello.txt s3://${aws_s3_bucket.logs.bucket}/logs/hello.txt --region ${var.aws_region}
  EOF

  user_data_replace_on_change = true

  tags = {
    Name    = "${var.project_name}-server"
    Project = var.project_name
  }
}

