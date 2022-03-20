variable "domain" {}
variable "env" {}
variable "vpc_id" {}
variable "main_vpc_cidr_block" {}
variable "image_id" {
  default = "ami-00ee4df451840fa9d"   # Amazon Linux 2 AMI (HVM), SSD Volume Type
}
variable "instance_type" {
  default = "t2.micro" 
}
variable "key_name" {}
variable "tags" {
    default = {}
}
variable "subnets" {
  default = []
}
variable "vpc_zone_identifier" {
  default = []
}