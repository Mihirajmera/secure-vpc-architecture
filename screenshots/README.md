# Screenshots

This directory contains screenshots for the Secure VPC Architecture project.

## Required Screenshots

To complete the project documentation, please add the following screenshots:

### 1. VPC Architecture
- **File**: `vpc-architecture.png`
- **Description**: Screenshot of VPC console showing the network architecture
- **How to capture**: 
  1. Navigate to AWS Console → VPC → Your VPCs
  2. Show the VPC with public and private subnets
  3. Display the subnet configuration and AZ distribution

### 2. Security Groups
- **File**: `security-groups.png`
- **Description**: Screenshot of security groups with least privilege rules
- **How to capture**:
  1. Navigate to AWS Console → VPC → Security Groups
  2. Show the ALB, EC2, and DB security groups
  3. Display inbound/outbound rules and their sources

### 3. Application Load Balancer
- **File**: `alb-console.png`
- **Description**: Screenshot of ALB configuration and health checks
- **How to capture**:
  1. Navigate to AWS Console → EC2 → Load Balancers
  2. Show the ALB configuration and target groups
  3. Display health check status and target health

### 4. EC2 Instance
- **File**: `ec2-instance.png`
- **Description**: Screenshot of EC2 instance in private subnet
- **How to capture**:
  1. Navigate to AWS Console → EC2 → Instances
  2. Show the EC2 instance details and placement
  3. Display the instance in private subnet with no public IP

### 5. VPC Flow Logs
- **File**: `flow-logs.png`
- **Description**: Screenshot of VPC Flow Logs in CloudWatch
- **How to capture**:
  1. Navigate to AWS Console → CloudWatch → Log Groups
  2. Show the VPC Flow Logs log group
  3. Display log streams and recent log entries

### 6. Nginx Application
- **File**: `nginx-app.png`
- **Description**: Screenshot of the Nginx application running
- **How to capture**:
  1. Get the ALB DNS name from Terraform output
  2. Open the URL in browser
  3. Show the "secure-vpc-architecture - Nginx up" page

## Adding Screenshots

1. Take screenshots using your preferred method
2. Save them in this directory with the exact filenames listed above
3. Commit and push to update the README display

## Note

These screenshots will be automatically displayed in the main README.md file once added to this directory.
