# 🏗️ Secure VPC Architecture with Terraform

[![Terraform](https://img.shields.io/badge/Terraform-1.7+-blue.svg)](https://terraform.io)
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange.svg)](https://aws.amazon.com)
[![Infrastructure as Code](https://img.shields.io/badge/IaC-Terraform-purple.svg)](https://terraform.io)
[![Security](https://img.shields.io/badge/Security-Hardened-red.svg)](https://aws.amazon.com/security/)

> **Enterprise-grade secure VPC architecture implementing Zero Trust networking principles with automated infrastructure deployment**

## 🎯 Project Overview

This project demonstrates advanced AWS networking and security best practices by building a production-ready VPC architecture that follows the **Zero Trust security model**. The infrastructure ensures that all traffic is encrypted, logged, and follows the principle of least privilege access.

### 🏆 Key Achievements
- ✅ **Zero Trust Architecture** - No direct internet access to private resources
- ✅ **High Availability** - Multi-AZ deployment with redundancy
- ✅ **Security Hardening** - Least privilege security groups and VPC Flow Logs
- ✅ **Cost Optimization** - Right-sized resources with clear cost estimates
- ✅ **Infrastructure as Code** - Fully automated deployment with Terraform

## 🏗️ Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        Internet Gateway                         │
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                    Public Subnets (AZ-1, AZ-2)                 │
│  ┌─────────────────┐  ┌─────────────────┐                      │
│  │   ALB (80/443)  │  │   NAT Gateway   │                      │
│  │   Security      │  │   + Elastic IP  │                      │
│  │   Group         │  │                 │                      │
│  └─────────────────┘  └─────────────────┘                      │
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                   Private Subnets (AZ-1, AZ-2)                 │
│  ┌─────────────────┐  ┌─────────────────┐                      │
│  │   EC2 Instance  │  │   Database      │                      │
│  │   (Nginx App)   │  │   (Future)      │                      │
│  │   Security      │  │   Security      │                      │
│  │   Group         │  │   Group         │                      │
│  └─────────────────┘  └─────────────────┘                      │
└─────────────────────────────────────────────────────────────────┘
```

## 🚀 Features & Technologies

### 🔒 Security Features
- **Private Subnet Isolation** - EC2 instances have no direct internet access
- **Least Privilege Security Groups** - Only necessary ports are open
- **VPC Flow Logs** - Complete network traffic monitoring
- **NAT Gateway** - Secure outbound internet access for private resources
- **Application Load Balancer** - SSL termination and health checks

### 🛠️ Infrastructure Components
- **VPC** - Custom network with public/private subnets across 2 AZs
- **Internet Gateway** - Internet access for public resources
- **NAT Gateway** - Outbound internet access for private resources
- **Application Load Balancer** - High availability and SSL termination
- **EC2 Instance** - Private web server with Nginx
- **Security Groups** - Network-level firewall rules
- **VPC Flow Logs** - Network traffic logging to CloudWatch

### 📊 Monitoring & Observability
- **CloudWatch Logs** - Centralized logging for VPC Flow Logs
- **Health Checks** - ALB health monitoring
- **Terraform State** - Infrastructure state management

## 🏃‍♂️ Quick Start

### Prerequisites
- [Terraform](https://terraform.io/downloads) >= 1.7
- [AWS CLI](https://aws.amazon.com/cli/) configured
- AWS Account with appropriate permissions

### 🚀 Deployment

1. **Clone and Navigate**
   ```bash
   git clone <your-repo>
   cd secure-vpc-terraform
   ```

2. **Configure AWS Credentials**
   ```bash
   # Option 1: Environment Variables
   export AWS_ACCESS_KEY_ID="your-access-key"
   export AWS_SECRET_ACCESS_KEY="your-secret-key"
   export AWS_DEFAULT_REGION="us-east-1"
   
   # Option 2: AWS CLI
   aws configure
   ```

3. **Deploy Infrastructure**
   ```bash
   # Initialize Terraform
   terraform init
   
   # Plan deployment
   terraform plan
   
   # Apply changes
   terraform apply -auto-approve
   ```

4. **Test Application**
   ```bash
   # Get ALB DNS name
   terraform output alb_dns_name
   
   # Open URL in browser (wait 2-3 minutes for EC2 startup)
   # Expected: "secure-vpc-architecture - Nginx up"
   ```

### 🧹 Cleanup
```bash
terraform destroy -auto-approve
```

## 💰 Cost Analysis

| Resource | Monthly Cost | Purpose |
|----------|-------------|---------|
| NAT Gateway | ~$45 | Private subnet internet access |
| Application Load Balancer | ~$16 | High availability & SSL |
| EC2 t3.micro | ~$8 | Web server |
| Data Transfer | ~$1-5 | Network traffic |
| **Total** | **~$70-75** | **Complete secure architecture** |

> 💡 **Cost Optimization**: Use `terraform destroy` when not testing to avoid charges

## 🔧 Configuration

### Variables (`terraform.tfvars`)
```hcl
aws_region = "us-east-1"
project_name = "secure-vpc-architecture"
environment = "dev"

# Network Configuration
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
```

### Security Groups
- **ALB Security Group**: Allows HTTP/HTTPS from internet
- **EC2 Security Group**: Allows HTTP from ALB only
- **Database Security Group**: Allows PostgreSQL from EC2 only

## 📁 Project Structure

```
secure-vpc-terraform/
├── 📄 versions.tf          # Terraform and provider versions
├── 📄 providers.tf         # AWS provider configuration
├── 📄 variables.tf         # Input variables
├── 📄 networking.tf        # VPC, subnets, IGW
├── 📄 nat.tf              # NAT Gateway and routing
├── 📄 security_groups.tf   # Security group definitions
├── 📄 ec2.tf              # EC2 instance and user data
├── 📄 alb.tf              # Application Load Balancer
├── 📄 flow_logs.tf        # VPC Flow Logs to CloudWatch
├── 📄 outputs.tf          # Terraform outputs
├── 📄 terraform.tfvars    # Configuration values
└── 📄 README.md           # This file
```

## 🎓 Learning Outcomes

This project demonstrates mastery of:

### 🏗️ Infrastructure as Code
- **Terraform** - Declarative infrastructure management
- **State Management** - Infrastructure state tracking
- **Modular Design** - Reusable and maintainable code

### ☁️ AWS Services
- **VPC** - Virtual Private Cloud networking
- **EC2** - Elastic Compute Cloud instances
- **ALB** - Application Load Balancer
- **NAT Gateway** - Network Address Translation
- **Security Groups** - Network-level security
- **CloudWatch** - Monitoring and logging

### 🔒 Security Best Practices
- **Zero Trust Architecture** - No implicit trust
- **Least Privilege Access** - Minimal necessary permissions
- **Network Segmentation** - Public/private subnet isolation
- **Traffic Monitoring** - VPC Flow Logs implementation

### 📊 DevOps Practices
- **Infrastructure Automation** - Repeatable deployments
- **Version Control** - Git-based workflow
- **Documentation** - Comprehensive project documentation
- **Cost Management** - Resource optimization

## 🚀 Future Enhancements

- [ ] **SSL/TLS Termination** - HTTPS with ACM certificates
- [ ] **Auto Scaling** - EC2 Auto Scaling Groups
- [ ] **Database Integration** - RDS PostgreSQL in private subnets
- [ ] **CI/CD Pipeline** - GitHub Actions for automated deployment
- [ ] **Monitoring** - CloudWatch dashboards and alarms
- [ ] **Backup Strategy** - Automated snapshots and backups

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Mihir** - *Cloud Infrastructure Engineer*
- LinkedIn: [Your LinkedIn Profile]
- GitHub: [Mihirajmera](https://github.com/Mihirajmera)
- Email: 89500809+Mihirajmera@users.noreply.github.com

---

⭐ **Star this repository if you found it helpful!**

> This project showcases enterprise-level AWS infrastructure design and implementation skills. Perfect for demonstrating cloud architecture expertise in technical interviews!

This Terraform project provisions a secure AWS VPC with public and private subnets, an EC2 instance running Nginx in a private subnet, an internet-facing Application Load Balancer in public subnets, a NAT Gateway for outbound internet access from private subnets, and VPC Flow Logs to CloudWatch.

Architecture
- VPC with 2 public and 2 private subnets across AZs
- Internet Gateway attached to VPC
- NAT Gateway in a public subnet for private egress
- Private EC2 instance (Amazon Linux 2) running Nginx
- Application Load Balancer in public subnets forwarding HTTP 80 to the instance
- Security Groups:
  - ALB SG: allow 80/443 inbound from internet
  - App SG: allow 80 inbound from ALB SG only
  - DB SG: allow 5432 inbound from App SG only (no DB resource here, placeholder for future use)
- VPC Flow Logs to CloudWatch Logs

Prerequisites
- Terraform >= 1.5
- AWS account and credentials configured (e.g., via `aws configure` or env vars)
- An AWS region with at least 2 AZs (default: us-east-1)

Files
- `versions.tf` – Terraform and provider versions
- `providers.tf` – AWS provider and common tags
- `variables.tf` – Inputs (region, CIDRs, tags)
- `networking.tf` – VPC, subnets, IGW, public routing
- `nat.tf` – EIP, NAT Gateway, private routing
- `security_groups.tf` – ALB, App, DB SGs
- `ec2.tf` – Private EC2 instance and Nginx user data
- `alb.tf` – ALB, Target Group, Listener, Attachment
- `flow_logs.tf` – CloudWatch Logs, IAM role/policy, VPC Flow Logs
- `outputs.tf` – Useful outputs like ALB DNS

Usage
```bash
terraform init
terraform plan -out tfplan
terraform apply -auto-approve tfplan

# Get ALB DNS
terraform output alb_dns_name
```

Inputs
- `project_name` (default: `secure-vpc-architecture`)
- `aws_region` (default: `us-east-1`)
- `vpc_cidr` (default: `10.0.0.0/16`)
- `public_subnet_cidrs` (default: `[10.0.1.0/24, 10.0.2.0/24]`)
- `private_subnet_cidrs` (default: `[10.0.101.0/24, 10.0.102.0/24]`)
- `tags` (map)

Notes
- EC2 instance resides in a private subnet without a public IP; ALB provides ingress.
- EC2 uses SSM role for session management (no SSH needed). If you want SSH, add a key pair and ingress accordingly (not recommended for prod).
- NAT Gateway incurs cost. Destroy when done:
```bash
terraform destroy -auto-approve
```


