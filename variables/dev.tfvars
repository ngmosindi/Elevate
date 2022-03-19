namespace = "Elevate"

region    = "us-west-2" 

profile_name = "default"

cidr_block = "10.0.0.0/16"

ami_id  = "ami-04a50faf2a2ec1901"

instance_type = "t2.micro"

alb_subnet_cidr = "10.0.100.0/24"

web_subnet1_cidr = "10.0.101.0/24"

web_subnet2_cidr = "10.0.102.0/24"

app_subnet1_cidr = "10.0.1.0/24"

app_subnet2_cidr = "10.0.2.0/24"

database_subnet1_cidr = "10.0.21.0/24"

database_subnet2_cidr = "10.0.22.0/24"

allocated_storage = "10"

engine  =  "mysql"

engine_version  = "8.0"

instance_class  = "db.t2.micro"

multi_az = true

name  = "elevate_rds"

username = "username"

password = "password"

skip_final_snapshot = true
