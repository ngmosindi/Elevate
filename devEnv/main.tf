module "network" {
  source            = "../modules/network"
  account_number    = "118544541080"
  region            = var.region
  domain            = var.domain
  env               = var.env


  main_vpc_cidr             = "10.0.0.0/16"
  main_subnet_elb_1a_cidr   = "10.0.100.0/24"
  main_subnet_elb_1b_cidr   = "10.0.101.0/24"
  main_subnet_web_1a_cidr   = "10.0.1.0/24"
  main_subnet_web_1b_cidr   = "10.0.2.0/24"
  main_subnet_app_1a_cidr   = "10.0.10.0/24"
  main_subnet_app_1b_cidr   = "10.0.11.0/24"
  
  main_subnet_db_1a_cidr    = "10.0.21.0/24"
  main_subnet_db_1b_cidr    = "10.0.22.0/24"

}
resource "aws_security_group" "mysql-sg" {
  name        = "${var.domain}-${var.env}-allow-mysql-sg"
  description = "Allow inbound traffic from application layer"
  vpc_id = module.network.main_vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow Database Security Group"
  }
}

module "mysql" {
  source            = "../modules/database"
  depends_on        = [module.network]
  env               = var.env
  vpc_id            = module.network.main_vpc_id
  subnet_group      = module.network.main_subnet_db_group
  identifier        = "elevate-rds"     
  database_name     = "elevate"
  database_username = "username"
  database_password = "password"
  multi_availability_zone = true
  vpc_security_group_ids = [aws_security_group.mysql-sg.id]
}

module "app" {
  source                = "../modules/app"
  depends_on            = [module.network]
  main_vpc_cidr_block   = module.network.main_vpc_cidr_block
  domain                = var.domain
  env                   = var.env
  key_name              = "oregonkeypair"
  vpc_id                = module.network.main_vpc_id
  subnets               = [module.network.main_subnet_elb_1a_id, module.network.main_subnet_elb_1b_id]
  vpc_zone_identifier   = [module.network.main_subnet_app_1a_id, module.network.main_subnet_app_1b_id]
}

module "web" {
  source                = "../modules/web"
  depends_on            = [module.network]
  main_vpc_cidr_block   = module.network.main_vpc_cidr_block
  domain                = var.domain
  env                   = var.env
  key_name              = "oregonkeypair"
  vpc_id                = module.network.main_vpc_id
  subnets               = [module.network.main_subnet_elb_1a_id, module.network.main_subnet_elb_1b_id]
  vpc_zone_identifier   = [module.network.main_subnet_web_1a_id, module.network.main_subnet_web_1b_id]
}