# AWS Credentials Configuration
# You can set these in multiple ways:

# Option 1: Environment Variables (Recommended)
# Set these in your terminal:
# export AWS_ACCESS_KEY_ID="your-access-key"
# export AWS_SECRET_ACCESS_KEY="your-secret-key"
# export AWS_DEFAULT_REGION="us-east-1"

# Option 2: AWS CLI Profile
# Run: aws configure
# Then set: export AWS_PROFILE="default"

# Option 3: Direct provider configuration (NOT recommended for production)
# Uncomment and fill in your credentials below:
# provider "aws" {
#   region     = var.aws_region
#   access_key = "YOUR_ACCESS_KEY_HERE"
#   secret_key = "YOUR_SECRET_KEY_HERE"
# }

# Option 4: AWS Credentials File
# Create ~/.aws/credentials with:
# [default]
# aws_access_key_id = YOUR_ACCESS_KEY
# aws_secret_access_key = YOUR_SECRET_KEY
# 
# And ~/.aws/config with:
# [default]
# region = us-east-1
