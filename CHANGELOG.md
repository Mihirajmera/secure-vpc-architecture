# Changelog

## Unreleased

- **Compliance evidence in CI:** Checkov results mapped to NIST 800-53 and CIS AWS v3.0.0, a reviewed exceptions register, and a gate that fails on unexcepted findings. Report and OSCAL output in `compliance/`.
- **Tightened egress:** security groups no longer allow all traffic to anywhere. The ALB can only reach the VPC on port 80, the app server only ports 80/443 through the NAT gateway, and the database has no egress.
- Default security group locked down (CIS AWS 5.4); app server root volume encrypted; public subnets no longer auto-assign public IPs; ALB drops invalid header fields; flow logs kept for one year.
## 1.0.0 (2026-10-17)

First tagged release. Multi-tier secure VPC in Terraform: segmented subnets, security groups, NACLs, NAT, ALB and flow logs.

- CI on Python 3.11 / current Terraform tooling with every GitHub Action pinned to a commit SHA
- CodeQL, OpenSSF Scorecard and Dependabot
- Security policy with private vulnerability reporting
