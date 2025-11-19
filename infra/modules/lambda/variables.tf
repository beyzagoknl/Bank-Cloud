variable "project_name" {
  type        = string
  description = "Project name"
}

variable "function_name" {
  type        = string
  description = "Lambda function name"
}

variable "runtime" {
  type        = string
  description = "Lambda runtime"
  default     = "nodejs18.x"
}

variable "handler" {
  type        = string
  description = "Lambda handler"
  default     = "index.handler"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for Lambda VPC config"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs for Lambda VPC config"
}

variable "environment" {
  type        = map(string)
  description = "Environment variables for Lambda"
  default     = {}
}
variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-west-1"
}

variable "deploy_environment" {
  type        = string
  description = "Deployment environment name like dev/test/prod"
}