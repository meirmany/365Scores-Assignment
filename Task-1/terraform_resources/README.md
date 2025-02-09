# Task Overview
## This project demonstrates a production AWS infrastructure deployment using Terraform.  
   It provisions:
- A VPC with two public and two private subnets.
- Route tables for each subnet.
- A security group that allows inbound HTTP (80) and HTTPS (443) traffic.
- An Application Load Balancer (ALB) that listens on ports 80 and 443 (with potential HTTPS redirection).
- A Route 53 hosted zone with an alias record pointing to the ALB.

**Recommendations for an extended secured environment:**
- Creating a NAT Gateway with an Elastic IP for secure outbound connectivity from private subnets.
- Define source IP in the inbound rules of the security group, in order to prevent access from unknown IP's.
- Consider adding SSL certificate configuration for ELB Access.


**This solution is designed to be production-ready following best practices using:**
- Modular architecture using Terraform modules 
- remote state management - using S3 bucket with DynamoDB
- environment isolationi - using environment and workspaces combine to isolate state per environment

## Setup Instructions:

**Define Credentials:**
- $ `aws configure`

**Initialize Terraform**
- $ `git clone https://github.com/meirmany/365Scores-Assignment.git`
- $ `cd Task-1/terraform_resources`
- $ `terraform init`

**List workspaces:**
- $ `terraform workspace list`

**Create/select a workspace:**
- $ `terraform workspace new prod`
- $ `terraform workspace select prod`


**Apply configuration using the environment-specific tfvars file:**
- $ `terraform plan -var-file=environments/dev/terraform.tfvars`
- $ `terraform apply -var-file=environments/dev/terraform.tfvars`

**Verifying Resources**
Check your AWS Console for VPC, subnets, ALB, and Route 53 records

**Destroying Resources**
- $ `terraform destroy -var-file=environments/dev/terraform.tfvars`
