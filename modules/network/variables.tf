variable "account_number" {}
variable "region" {}
variable "domain" {}
variable "env" {}

#############################
# Main VPC
#############################
variable "main_vpc_cidr" {}
variable "main_subnet_elb_1a_cidr" {}
variable "main_subnet_elb_1b_cidr" {}

variable "main_subnet_web_1a_cidr" {}
variable "main_subnet_web_1b_cidr" {}

variable "main_subnet_app_1a_cidr" {}
variable "main_subnet_app_1b_cidr" {}

variable "main_subnet_db_1a_cidr" {}
variable "main_subnet_db_1b_cidr" {}

