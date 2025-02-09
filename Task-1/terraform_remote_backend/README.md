# terraform_remote_backend

**Goal**
- Creating remote backend as best pratice for production environment
- Enabling remote versioning state file for restore scnarios 

**Deployment Components:**
- An S3 bucket for storing state files 
- A DynamoDB table for state locking 

**Pre Requisites:**
- Install terraform with updated version
- Install aws cli with updated version

**Setup Instructions:**
- $ `git clone https://github.com/meirmany/365Scores-Assignment.git` 
- $ `cd 365Scores-Assignment/Task-1/terraform_remote_backend`
- $ `aws configure`
- $ `terraform init`
- $ `terraform plan`
- $ `terraform apply`

**After deployment is completed, you may continue with phase2, installing resources.**
