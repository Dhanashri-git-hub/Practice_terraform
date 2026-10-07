terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Allows minor version upgrades, pinning the major version
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
