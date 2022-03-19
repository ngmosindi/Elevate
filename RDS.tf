#Create database
resource "aws_db_instance" "default" {
  allocated_storage      = var.allocated_storage
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  multi_az               = var.multi_az
  name                   = var.name
  username               = var.username
  password               = var.password
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}