# Welcome to the NovaBank Cloud PoC

This repository contains a small demonstration application built for NovaBank as part of their first steps into the public cloud.

The purpose of this PoC is simple:

- expose a minimal **health check API**,
- run on fully automated **AWS infrastructure**,
- demonstrate **VPC-isolated deployments**,
- centralize application logs, and  
- show how NovaBank can confidently begin its cloud journey.

This is a lightweight, low-cost, fully Infrastructure-as-Code (IaC) proof of concept — not a production system.

- API Gateway (HTTP API)
- AWS Lambda Function
- PostgreSQL RDS (Free Tier)
- Private VPC & Subnets
- Centralized logging (S3 + CloudWatch)

# Bank-Cloud# NovaBank Cloud PoC (AWS + Terraform)

This repository contains a minimal Proof of Concept (PoC) for deploying NovaBank’s first cloud environment on AWS using Terraform.  
The PoC includes:

- API Gateway (HTTP API)
- Lambda Function
- PostgreSQL RDS (Free Tier)
- Private VPC & Subnets
- Central centralized logging (CloudWatch + S3)
- Fully automated Infrastructure as Code (IaC)

---

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
        | returns JSON      | queries DB       | stores data
        v                   v                  v
      Client <----------- Health Check <---- Database
