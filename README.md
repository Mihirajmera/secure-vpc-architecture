# 🏗️ Secure VPC Architecture with Terraform

Enterprise-grade secure VPC architecture implementing Zero Trust networking principles with automated infrastructure deployment

## 🎯 Project Overview

This project demonstrates advanced AWS networking and security best practices by building a production-ready VPC architecture that follows the Zero Trust security model. The infrastructure ensures that all traffic is encrypted, logged, and follows the principle of least privilege access.

## 🏆 Key Achievements

- ✅ Zero Trust Architecture - No direct internet access to private resources
- ✅ High Availability - Multi-AZ deployment with redundancy
- ✅ Security Hardening - Least privilege security groups and VPC Flow Logs
- ✅ Cost Optimization - Right-sized resources with clear cost estimates
- ✅ Infrastructure as Code - Fully automated deployment with Terraform

## 🏗️ Architecture Diagram

```mermaid
graph TD
    classDef public fill:#e1f5fe,stroke:#0288d1,stroke-width:2px;
    classDef private fill:#e8f5e9,stroke:#388e3c,stroke-width:2px;
    classDef monitor fill:#fff9c4,stroke:#fbc02d,stroke-width:2px;

    IGW[Internet Gateway] --> ALBSG

    subgraph Public [Public Subnets - AZ1 / AZ2]
        ALBSG[ALB<br/>80 / 443<br/>Security Group]
        NAT[NAT Gateway<br/>+ Elastic IP]
    end

    ALBSG -->|Forward HTTP| EC2
    NAT -->|Outbound egress| Internet[(Internet)]

    subgraph Private [Private Subnets - AZ1 / AZ2]
        EC2[EC2 Instance<br/>Nginx App<br/>Security Group]
        DB[(Database - Future<br/>Security Group)]
        EC2 -.->|via NAT| NAT
    end

    EC2 --> FL[VPC Flow Logs]
    FL --> CW[CloudWatch Logs]

    class IGW,ALBSG,NAT public;
    class EC2,DB private;
    class FL,CW monitor;
```

## 🚀 Features & Technologies

### 🔒 Security Features
- Private Subnet Isolation - EC2 instances have no direct internet access
- Least Privilege Security Groups - Only necessary ports are open
- VPC Flow Logs - Complete network traffic monitoring
- NAT Gateway - Secure outbound internet access for private resources
- Application Load Balancer - SSL termination and health checks

### 🛠️ Infrastructure Components
- VPC - Custom network with public/private subnets across 2 AZs
- Internet Gateway - Internet access for public resources
- NAT Gateway - Outbound internet access for private resources
- Application Load Balancer - High availability and SSL termination
- EC2 Instance - Private web server with Nginx
- Security Groups - Network-level firewall rules
- VPC Flow Logs - Network traffic logging to CloudWatch

### 📊 Monitoring & Observability
- CloudWatch Logs - Centralized logging for VPC Flow Logs
- Health Checks - ALB health monitoring
- Terraform State - Infrastructure state management

## 🔒 Security Group Rules

| Security Group | Rule | Purpose |
|---|---|---|
| ALB SG | Allow 80/443 inbound from internet | Public ingress |
| App SG | Allow 80 inbound from ALB SG only | No direct internet exposure |
| DB SG | Allow 5432 inbound from App SG only | Placeholder for future RDS use |

## 🏃‍♂️ Quick Start

### Prerequisites
- Terraform >= 1.7
- AWS CLI configured
- AWS Account with appropriate permissions

### 🚀 Deployment

**Clone and Navigate**
```bash
git clone <your-repo>
cd secure-vpc-terraform
```

**Configure AWS Credentials**
```bash
# Option 1: Environment Variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"

# Option 2: AWS CLI
aws configure
```

**Deploy Infrastructure**
```bash
# Initialize Terraform
terraform init

# Plan deployment
terraform plan -out tfplan

# Apply changes
terraform apply -auto-approve tfplan
```

**Test Application**
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
|---|---|---|
| NAT Gateway | ~$45 | Private subnet internet access |
| Application Load Balancer | ~$16 | High availability & SSL |
| EC2 t3.micro | ~$8 | Web server |
| Data Transfer | ~$1-5 | Network traffic |
| **Total** | **~$70-75** | Complete secure architecture |

💡 **Cost Optimization**: Use `terraform destroy` when not testing to avoid charges

## 🔧 Configuration

### Variables (terraform.tfvars)
```hcl
aws_region   = "us-east-1"
project_name = "secure-vpc-architecture"
environment  = "dev"

# Network Configuration
vpc_cidr              = "10.0.0.0/16"
public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]
```

### Inputs

| Variable | Default |
|---|---|
| `project_name` | `secure-vpc-architecture` |
| `aws_region` | `us-east-1` |
| `vpc_cidr` | `10.0.0.0/16` |
| `public_subnet_cidrs` | `[10.0.1.0/24, 10.0.2.0/24]` |
| `private_subnet_cidrs` | `[10.0.101.0/24, 10.0.102.0/24]` |
| `tags` | map |

## 📁 Project Structure

```
secure-vpc-terraform/
├── versions.tf              # Terraform and provider versions
├── providers.tf             # AWS provider configuration
├── variables.tf             # Input variables
├── networking.tf            # VPC, subnets, IGW, public routing
├── nat.tf                   # EIP, NAT Gateway, private routing
├── security_groups.tf       # ALB, App, DB security groups
├── ec2.tf                   # Private EC2 instance and Nginx user data
├── alb.tf                   # ALB, Target Group, Listener, Attachment
├── flow_logs.tf             # CloudWatch Logs, IAM role/policy, VPC Flow Logs
├── outputs.tf                # Terraform outputs (e.g. ALB DNS)
├── terraform.tfvars          # Configuration values
└── README.md                 # This file
```

## 📝 Notes
- EC2 instance resides in a private subnet without a public IP; the ALB provides ingress.
- EC2 uses an SSM role for session management (no SSH needed). If you want SSH, add a key pair and ingress accordingly (not recommended for production).
- The NAT Gateway incurs cost — run `terraform destroy -auto-approve` when done testing.

## 🎓 Learning Outcomes

This project demonstrates mastery of:

### 🏗️ Infrastructure as Code
- Terraform - Declarative infrastructure management
- State Management - Infrastructure state tracking
- Modular Design - Reusable and maintainable code

### ☁️ AWS Services
- VPC - Virtual Private Cloud networking
- EC2 - Elastic Compute Cloud instances
- ALB - Application Load Balancer
- NAT Gateway - Network Address Translation
- Security Groups - Network-level security
- CloudWatch - Monitoring and logging

### 🔒 Security Best Practices
- Zero Trust Architecture - No implicit trust
- Least Privilege Access - Minimal necessary permissions
- Network Segmentation - Public/private subnet isolation
- Traffic Monitoring - VPC Flow Logs implementation

### 📊 DevOps Practices
- Infrastructure Automation - Repeatable deployments
- Version Control - Git-based workflow
- Documentation - Comprehensive project documentation
- Cost Management - Resource optimization

## 🚀 Future Enhancements
- SSL/TLS Termination - HTTPS with ACM certificates
- Auto Scaling - EC2 Auto Scaling Groups
- Database Integration - RDS PostgreSQL in private subnets
- CI/CD Pipeline - GitHub Actions for automated deployment
- Monitoring - CloudWatch dashboards and alarms
- Backup Strategy - Automated snapshots and backups

## 🤝 Contributing
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author
**Mihir Ajmera** — GRC Engineer & Cloud Security

- LinkedIn: [Mihir Ajmera](https://linkedin.com/in/mihirajmera)
- GitHub: [Mihirajmera](https://github.com/Mihirajmera)
- Email: ajmera.mihir.79@gmail.com

⭐ Star this repository if you found it helpful!

*This project showcases enterprise-level AWS infrastructure design and implementation — demonstrating cloud architecture expertise for technical interviews.*
