# IaC compliance evidence: secure-vpc-architecture

Checkov 3.3.22 scanned the Terraform on 2026-10-21. Scan output SHA-256: `922a28dd4db66637…`.

| Passed | Failed, open | Failed, exception | Unique checks |
|---:|---:|---:|---:|
| 93 | **0** | 13 | 56 |

**Gate:** CI fails if any failed check lacks a reviewed, unexpired exception.

## Exceptions

Reviewed 2026-10-21 by Mihir Ajmera. Each one is a decision with a reason and an expiry, not a suppression.

| Check | Resource | Decision | Reason | Expires | NIST 800-53 |
|---|---|---|---|---|---|
| CKV2_AWS_20 Ensure that ALB redirects HTTP requests into HTTPS ones | `aws_lb.app_alb` | deferred | Same as CKV_AWS_2; the HTTP-to-HTTPS redirect needs the HTTPS listener. | 2027-01-31 | SC-8 |
| CKV2_AWS_28 Ensure public facing ALB are protected by WAF | `aws_lb.app_alb` | deferred | Attach an AWS WAF web ACL with the managed core rule set before production traffic. | 2027-01-31 | SC-7, SI-4 |
| CKV2_AWS_5 Ensure that Security Groups are attached to another resource | `aws_security_group.db_sg` | not-applicable | The database security group is defined ahead of the data tier so its rules (app-only ingress, no egress) are reviewed before any database exists. | 2027-04-21 | CM-7 |
| CKV_AWS_103 Ensure that load balancer is using at least TLS 1.2 | `aws_lb_listener.http` | deferred | Same as CKV_AWS_2; the TLS policy applies once the HTTPS listener exists. | 2027-01-31 | SC-8, SC-13 |
| CKV_AWS_126 Ensure that detailed monitoring is enabled for EC2 instances | `aws_instance.app` | not-applicable | One t3.micro demo instance; basic 5-minute metrics are enough and detailed monitoring is billed. | 2027-04-21 | SI-4 |
| CKV_AWS_135 Ensure that EC2 is EBS optimized | `aws_instance.app` | not-applicable | Performance setting, not a security control; t3 instances are EBS-optimized by default. | 2027-04-21 | SC-5 |
| CKV_AWS_150 Ensure that Load Balancer has deletion protection enabled | `aws_lb.app_alb` | not-applicable | Reference environment that is created and destroyed with deploy.sh; deletion protection would block teardown. | 2027-04-21 | CM-3 |
| CKV_AWS_158 Ensure that CloudWatch Log Group is encrypted by KMS | `aws_cloudwatch_log_group.vpc_flow_logs` | risk-accepted | Flow logs are encrypted with the CloudWatch Logs service key. A customer-managed KMS key adds key-policy management with little benefit for network metadata. | 2027-04-21 | SC-28 |
| CKV_AWS_2 Ensure ALB protocol is HTTPS | `aws_lb_listener.http` | deferred | HTTPS needs a domain and an ACM certificate, which this reference deployment doesn't have. Add a 443 listener with TLS 1.2+ and redirect 80 to it before serving real traffic. | 2027-01-31 | SC-8 |
| CKV_AWS_260 Ensure no security groups allow ingress from 0.0.0.0:0 to port 80 | `aws_security_group.alb_sg` | risk-accepted | The internet-facing load balancer must accept port 80 to serve the site (and later to redirect to HTTPS). Only the load balancer is exposed; instances are in private subnets. | 2027-04-21 | SC-7, AC-4 |
| CKV_AWS_378 Ensure AWS Load Balancer doesn't use HTTP protocol | `aws_lb_target_group.app_tg` | risk-accepted | HTTP between the load balancer and the app stays inside the VPC, restricted by security groups to the ALB only. TLS terminates at the load balancer. | 2027-04-21 | SC-8 |
| CKV_AWS_394 Ensure aws_availability_zones data source pins zone identity so its result set does not silently expand when AWS adds an Availability Zone | `aws_availability_zones.available` | deferred | Filter availability zones by zone ID so the subnet layout can't shift if AWS adds zones. | 2027-01-31 | CM-2 |
| CKV_AWS_91 Ensure the ELBv2 (Application/Network) has access logging enabled | `aws_lb.app_alb` | deferred | Load balancer access logs need a dedicated S3 bucket with a delivery policy; VPC flow logs cover network-level evidence meanwhile. | 2027-01-31 | AU-2, AU-12 |

## Passed checks by NIST 800-53 control

| Control | Passed checks |
|---|---:|
| AC-2 | 3 |
| AC-3 | 12 |
| AC-4 | 19 |
| AC-6 | 43 |
| AU-11 | 2 |
| AU-12 | 1 |
| CM-2 | 1 |
| CM-6 | 4 |
| CM-7 | 3 |
| IA-5 | 6 |
| IA-8 | 5 |
| SC-13 | 1 |
| SC-28 | 1 |
| SC-5 | 1 |
| SC-7 | 31 |
| SC-8 | 1 |
| SI-10 | 2 |
| SI-3 | 1 |
| SI-4 | 1 |
| SI-7 | 1 |

Mappings to NIST 800-53 and CIS are my own judgment ([`iac_controls.yaml`](iac_controls.yaml)); checks without a mapping are counted as *unmapped*.
