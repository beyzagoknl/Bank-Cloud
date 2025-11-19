# NovaBank Cloud PoC (AWS + Terraform)

This repository contains a lightweight **Proof of Concept (PoC)** environment designed to help **NovaBank** begin its cloud journey on AWS using fully automated **Infrastructure as Code (IaC)**.

The PoC demonstrates:

- A minimal **Health Check API**
- **VPC-isolated** application components
- A secure **PostgreSQL RDS** database
- A serverless **Lambda-based** compute layer
- Centralized **logging and observability** (CloudWatch + S3)
- Secure secret handling using **SSM Parameter Store**

This is intentionally simple, low-cost, and **not a production system**.

---
## Architecture Overview

This PoC deploys:

- **Amazon API Gateway (HTTP API)**  
- **AWS Lambda (Node.js 18)**  
- **Amazon RDS for PostgreSQL** (Free Tier–eligible)
- A private **VPC with two subnets**
- **CloudWatch Logs** (400-day retention)
- **S3 Logging Bucket** (encrypted, lifecycle-enabled)

All secrets, including the database password, are stored in **SSM Parameter Store (SecureString)**.

---

## Security Features

- RDS and Lambda deployed in **private subnets**
- **Security groups** follow least-privilege rules
- Database password stored in **SSM**, not in plaintext Λambda environment variables
- S3 logging bucket:
  - Server-side encryption
  - Public access blocked
  - Lifecycle configuration enabled
- IAM roles use minimal permissions
- CloudWatch log retention: **400 days**
- Uniform tagging applied through Terraform `default_tags`

## 1. Requirements

Install the following:

```bash
# Terraform
brew install terraform

# AWS CLI
brew install awscli
aws configure

# Node.js (for Lambda packaging)
brew install node


export TF_VAR_db_username="novabank_master"
export TF_VAR_db_password="NovaBank123!"
export TF_VAR_region="eu-central-1"
export TF_VAR_environment="dev"

cd infra
terraform init
terraform workspace new dev        # only first time
terraform workspace select dev
terraform apply
terraform output


             +----------------------+
             | Developer Machine    |
             | (Terraform Apply)    |
             +----------+-----------+
                        |
                        v
             +----------------------+
             | Terraform (IaC)      |
             | Creates AWS Resources|
             +----------+-----------+
                        |
        ------------------------------------------------
        |                  |                  |        |
        v                  v                  v        v
+---------------+  +----------------+  +-------------+ +----------------+
| API Gateway   |  | Lambda         |  | RDS         | | S3 Logging     |
| (HTTP API)    |->| index.handler  |->| PostgreSQL  | | CloudWatch     |
+-------+-------+  +--------+-------+  +------+------+ +----------------+
        |                   |                  |
        | Returns JSON      | Queries DB       | Stores Logs
        v                   v                  v
      Client <----------- Health Check <---- Database
