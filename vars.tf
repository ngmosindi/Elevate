variable "namespace" {}

variable "region" {}

variable "profile_name" {}

variable "cidr_block" {}

variable "availability_zone_names" {
     default = ["us-west-2a", "us-west-2b", "us-west-2c"]
     }

variable "ami_id" {}

variable "instance_type" {}

variable "alb_subnet_cidr" {}

variable "web_subnet1_cidr" {}

variable "web_subnet2_cidr" {}

variable app_subnet1_cidr {}
    
variable "app_subnet2_cidr" {}

variable "database_subnet1_cidr" {}

variable "database_subnet2_cidr" {}

variable "allocated_storage" {}

variable "engine" {}

variable "engine_version" {}

variable "instance_class" {}

variable "multi_az" {}

variable "name" {}

variable "username" {}

variable "password" {}

variable "skip_final_snapshot" {}
