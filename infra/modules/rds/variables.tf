variable "project_name" {
  type        = string
  description = "Project name"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for RDS subnet group"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security groups for RDS instance"
}

variable "database_name" {
  type        = string
  description = "Database name"
}

variable "username" {
  type        = string
  description = "Master username"
}

variable "password" {
  type        = string
  description = "Master password"
  sensitive   = true
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage (GiB)"
  default     = 20
}

variable "instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.t4g.micro"
}

variable "backup_retention_days" {
  type        = number
  description = "Backup retention in days"
  default     = 7
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ"
  default     = true
}