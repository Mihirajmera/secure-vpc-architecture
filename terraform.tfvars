# AWS Configuration
aws_region = "us-east-1"

# Project Configuration
project_name = "secure-vpc-architecture"
environment = "dev"

# Network Configuration
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]

# Tags
tags = {
  Owner = "Mihir"
  Purpose = "Learning"
  Environment = "Development"
}
