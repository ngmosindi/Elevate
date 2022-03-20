###############
# RDS Resource
###############

resource "aws_db_instance" "mysql" {
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  engine                          = var.engine
  engine_version                  = var.engine_version

  instance_class                  = var.instance_type
  storage_type                    = var.storage_type
  iops                            = var.iops
  identifier                      = var.identifier
  db_name                         = var.database_name
  password                        = var.database_password
  username                        = var.database_username
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window
  maintenance_window              = var.maintenance_window
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled == true ? var.performance_insights_retention_period : null

  final_snapshot_identifier       = var.final_snapshot_identifier
  skip_final_snapshot             = var.skip_final_snapshot
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  multi_az                        = var.multi_availability_zone
  port                            = var.database_port
  publicly_accessible             = var.publicly_accessible

  vpc_security_group_ids          = var.vpc_security_group_ids
  db_subnet_group_name            = var.subnet_group

  storage_encrypted               = var.storage_encrypted

  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = merge(
    {
      Name        = "DatabaseServer",
      Environment = var.env,
      Terraform   = true
    },
    var.tags
  )
}

