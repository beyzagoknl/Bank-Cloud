terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project      = var.project_name
      Environment  = var.environment  
      Owner        = "squad-meso"
      CostCenter   = "novabank"
      ManagedBy    = "terraform"
    }
  }
}

# VPC + Security Groups
module "vpc" {
  source = "./modules/vpc"

  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  private_subnet_cidrs  = var.private_subnet_cidrs
}

# RDS PostgreSQL
module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  subnet_ids            = module.vpc.private_subnet_ids
  vpc_security_group_ids = [module.vpc.rds_sg_id]

  database_name = var.db_name
  username      = var.db_username
  password      = var.db_password
}

# Lambda Function
module "lambda" {
  source = "./modules/lambda"

  project_name       = var.project_name
  function_name      = var.lambda_function_name
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.vpc.lambda_sg_id]
  region             = var.region

  environment = {
    DB_HOST           = module.rds.endpoint
    DB_NAME           = var.db_name
    DB_USER           = var.db_username
    DB_PASSWORD_PARAM = aws_ssm_parameter.db_password.name
  }

  deploy_environment = var.environment  # BURADA DEV/PROD DEĞİŞKENİNİ VER
}

# API Gateway HTTP API
module "apigw" {
  source = "./modules/apigw"

  project_name         = var.project_name
  lambda_arn           = module.lambda.lambda_arn
  lambda_function_name = module.lambda.lambda_name
}

# Logging S3 Bucket (for log archive)
module "logging" {
  source       = "./modules/logging"
  project_name = var.project_name
}
# Store DB password in SSM Parameter Store
resource "aws_ssm_parameter" "db_password" {
  name        = "/novabank/${var.environment}/db_password"
  type        = "SecureString"
  value       = var.db_password
  description = "NovaBank DB password"

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}