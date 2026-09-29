# AWS Private Server (Terraform)

**Goal:** A server that isn't directly reachable from the internet, but can
still download updates and save its logs.

I'm learning Terraform by building this one stage at a time. Each stage is a
separate commit, so the history shows how the project grew.

## Stages
- [x] Stage 1: EC2 instance + S3 bucket
- [ ] Stage 2: IAM role so EC2 can write to S3
- [ ] Stage 3: Custom VPC + private subnet
- [ ] Stage 4: NAT gateway
- [ ] Stage 5: Refactor into modules

## What Stage 1 builds
- An EC2 instance (`t3.micro`, latest Amazon Linux 2023) in the default VPC
- An S3 bucket with a random suffix for a unique name, with all public
  access blocked

## Prerequisites
- Terraform >= 1.5
- AWS CLI configured (`aws configure`) with region `ap-south-1`

## How to run
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Clean up when done, to avoid charges:
```bash
terraform destroy
```

## What I learned / what broke
- [One thing that confused you, e.g. why the plan showed 4 resources]
- Committed the `.terraform/` folder by accident and GitHub rejected the push
  (provider binary over 100 MB). Fixed by adding a `.gitignore` and
  re-initialising the repo.

