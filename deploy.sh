#!/bin/bash

# Secure VPC Architecture Deployment Script
echo "🚀 Starting Secure VPC Architecture Deployment..."

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Terraform is not installed. Please install it first."
    exit 1
fi

# Check AWS credentials
echo "🔍 Checking AWS credentials..."
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS credentials not configured. Please set them up first."
    echo ""
    echo "Choose one of these options:"
    echo "1. Set environment variables:"
    echo "   export AWS_ACCESS_KEY_ID=\"your-access-key\""
    echo "   export AWS_SECRET_ACCESS_KEY=\"your-secret-key\""
    echo "   export AWS_DEFAULT_REGION=\"us-east-1\""
    echo ""
    echo "2. Configure AWS CLI:"
    echo "   aws configure"
    echo ""
    echo "3. Create AWS credentials file:"
    echo "   ~/.aws/credentials"
    exit 1
fi

echo "✅ AWS credentials found!"

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init

if [ $? -ne 0 ]; then
    echo "❌ Terraform initialization failed!"
    exit 1
fi

# Plan the deployment
echo "📋 Planning deployment..."
terraform plan -out=tfplan

if [ $? -ne 0 ]; then
    echo "❌ Terraform plan failed!"
    exit 1
fi

# Ask for confirmation
echo ""
echo "⚠️  This will create AWS resources that may incur costs."
echo "💰 Estimated monthly cost: ~$15-25 (mainly NAT Gateway)"
echo ""
read -p "Do you want to proceed with deployment? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Deployment cancelled."
    exit 1
fi

# Apply the deployment
echo "🚀 Deploying infrastructure..."
terraform apply -auto-approve tfplan

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Deployment successful!"
    echo ""
    echo "📊 Getting outputs..."
    terraform output
    
    echo ""
    echo "🌐 To test your application:"
    echo "1. Wait 2-3 minutes for EC2 instance to start"
    echo "2. Get the ALB DNS name: terraform output alb_dns_name"
    echo "3. Open the URL in your browser"
    echo ""
    echo "🧹 To destroy resources when done:"
    echo "   terraform destroy -auto-approve"
else
    echo "❌ Deployment failed!"
    exit 1
fi
