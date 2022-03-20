variable "env" {}
variable "vpc_id" {}
variable "subnet_group" {}
variable "publicly_accessible" {
  default = false
}
variable "performance_insights_enabled" {
  default = false
}
variable "performance_insights_retention_period" {
  default = 7
}
variable "iam_partition" {
  default  = "aws"
}

variable "database_name" {}
variable "database_username" {}
variable "database_password" {}
variable "vpc_security_group_ids" {
  default = []
}
variable "database_port" {
  default   = 3306
}
variable "allocated_storage" {
  default   = 20
}
variable "max_allocated_storage" {
  default = 1000
}
variable "engine" {
  default = "mysql"
}
variable "engine_version" {
  default   = "8.0"
}
variable "instance_type" {
  default   = "db.t2.micro"
}
variable "storage_type" {
  default   = "gp2"
}
variable "iops" {
  default   = 0
}
variable "backup_retention_period" {
  default   = 7
}
variable "backup_window" {
  default     = "04:00-04:30"
  description = "30 minute time window to reserve for backups"
}
variable "maintenance_window" {
  default     = "sun:04:30-sun:05:30"
  description = "60 minute time window to reserve for maintenance"
}
variable "auto_minor_version_upgrade" {
  default     = true
}
variable "identifier" {}
variable "final_snapshot_identifier" {
  default     = "terraform-aws-postgresql-rds-snapshot"
}
variable "skip_final_snapshot" {
  default     = true
}
variable "copy_tags_to_snapshot" {
  default     = false
}
variable "multi_availability_zone" {
  default     = false
}
variable "storage_encrypted" {
  default     = false
}
variable "monitoring_interval" {
  default     = 0
}
variable "deletion_protection" {
  default     = false
}
variable "enabled_cloudwatch_logs_exports" {
  default     = []
}
variable "tags" {
    default = {}
}