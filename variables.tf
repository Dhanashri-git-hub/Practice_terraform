variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Prefix used for naming resources"
  type        = string
  default     = "aws-private-server"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}

variable "Practice_Terraform" {
  description = "Name prefix for the server instance"
  type        = string
  default     = "practice"
}
