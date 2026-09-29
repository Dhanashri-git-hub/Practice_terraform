# Find the latest Amazon Linux 2023 image instead of hardcoding an AMI ID
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
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  tags = {
    Name    = "${var.Practice_Terraform}-server"
    Project = var.project_name
  }
}

