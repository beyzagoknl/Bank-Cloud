resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-rds-subnets"
  subnet_ids = var.subnet_ids

  tags = {
    Name    = "${var.project_name}-rds-subnets"
    Project = var.project_name
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.project_name}-postgres"
  engine                  = "postgres"
  engine_version          = "15.5"
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  db_name                 = var.database_name
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  multi_az                = var.multi_az
  publicly_accessible     = false
  storage_encrypted       = true
  backup_retention_period = var.backup_retention_days
  deletion_protection     = false

  auto_minor_version_upgrade = true
  copy_tags_to_snapshot      = true

  tags = {
    Name    = "${var.project_name}-postgres"
    Project = var.project_name
  }
}