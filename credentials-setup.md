# AWS Credentials Setup Guide

## Quick Setup Options

### Option 1: Environment Variables (Recommended)
```bash
# Set these in your terminal session
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="us-east-1"

# Verify credentials
aws sts get-caller-identity
```

### Option 2: AWS CLI Configuration
```bash
# Run this command and enter your credentials when prompted
aws configure

# Enter:
# AWS Access Key ID: YOUR_ACCESS_KEY_ID
# AWS Secret Access Key: YOUR_SECRET_ACCESS_KEY
# Default region: us-east-1
# Default output format: json
```

### Option 3: Credentials File
Create `~/.aws/credentials`:
```ini
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
```

Create `~/.aws/config`:
```ini
[default]
region = us-east-1
output = json
```

## Deploy the Infrastructure

### Method 1: Using the deployment script
```bash
cd Projects/secure-vpc-terraform
chmod +x deploy.sh
./deploy.sh
```

### Method 2: Manual deployment
```bash
cd Projects/secure-vpc-terraform
terraform init
terraform plan
terraform apply -auto-approve
```

## After Deployment

1. **Get the ALB DNS name:**
   ```bash
   terraform output alb_dns_name
   ```

2. **Test the application:**
   - Wait 2-3 minutes for EC2 to start
   - Open the ALB DNS URL in your browser
   - You should see: "secure-vpc-architecture - Nginx up"

3. **Clean up when done:**
   ```bash
   terraform destroy -auto-approve
   ```

## What Gets Created

- **VPC** with public and private subnets
- **Internet Gateway** for public access
- **NAT Gateway** for private subnet outbound access
- **Security Groups** with least privilege rules
- **EC2 Instance** running Nginx in private subnet
- **Application Load Balancer** in public subnets
- **VPC Flow Logs** to CloudWatch

## Cost Estimate

- **NAT Gateway**: ~$45/month (main cost)
- **ALB**: ~$16/month
- **EC2 t3.micro**: ~$8/month
- **Data transfer**: ~$1-5/month
- **Total**: ~$70-75/month

**Note**: Remember to destroy resources when done to avoid charges!
