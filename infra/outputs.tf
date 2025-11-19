output "api_invoke_url" {
  description = "Base URL of the HTTP API"
  value       = module.apigw.invoke_url
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = module.rds.endpoint
}

output "logs_bucket_name" {
  description = "S3 bucket name for log archival"
  value       = module.logging.bucket_name
}