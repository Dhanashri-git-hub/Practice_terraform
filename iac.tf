# Using the AWS Assumerole feature to for temprary IAM Access
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
# Create a IAM role server
resource "aws_iam_role" "server" {
  name               = "${var.project_name}-server-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# IAM role can just write logs in s3
data "aws_iam_policy_document" "write_logs" {
  statement {
    actions   = ["s3:PutObject"] # Allows uploading files to s3 buckets
    resources = ["${aws_s3_bucket.logs.arn}/*"]
  }
}

resource "aws_iam_role_policy" "write_logs" {
  name   = "write-logs-to-s3"
  role   = aws_iam_role.server.id
  policy = data.aws_iam_policy_document.write_logs.json
}

#Creates a Instance profile that allows EC2 instances to pass an IAM role to virtual machines.
resource "aws_iam_instance_profile" "server" {
  name = "${var.project_name}-server-profile"
  role = aws_iam_role.server.name
}