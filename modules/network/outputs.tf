output "region" {
  value = var.region
}
output "main_vpc_id" {
  value = aws_vpc.main_vpc.id
}
output "main_vpc_ngw" {
  value = aws_eip.main_ngw_eip.public_ip
}
output "main_vpc_cidr_block" {
  value = aws_vpc.main_vpc.cidr_block
}
output "main_subnet_elb_1a_id" {
  value = aws_subnet.main_subnet_elb_1a.id
}
output "main_subnet_elb_1a_cidr_block" {
  value = aws_subnet.main_subnet_elb_1a.cidr_block
}
output "main_subnet_elb_1b_id" {
  value = aws_subnet.main_subnet_elb_1b.id
}
output "main_subnet_elb_1b_cidr_block" {
  value = aws_subnet.main_subnet_elb_1b.cidr_block
}

output "main_subnet_web_1a_id" {
  value = aws_subnet.main_subnet_web_1a.id
}
output "main_subnet_web_1a_cidr_block" {
  value = aws_subnet.main_subnet_web_1a.cidr_block
}
output "main_subnet_web_1b_id" {
  value = aws_subnet.main_subnet_web_1b.id
}
output "main_subnet_web_1b_cidr_block" {
  value = aws_subnet.main_subnet_web_1b.cidr_block
}

output "main_subnet_app_1a_id" {
  value = aws_subnet.main_subnet_app_1a.id
}
output "main_subnet_app_1a_cidr_block" {
  value = aws_subnet.main_subnet_app_1a.cidr_block
}
output "main_subnet_app_1b_id" {
  value = aws_subnet.main_subnet_app_1b.id
}
output "main_subnet_app_1b_cidr_block" {
  value = aws_subnet.main_subnet_app_1b.cidr_block
}

output "main_subnet_db_1a_id" {
  value = aws_subnet.main_subnet_db_1a.id
}
output "main_subnet_db_1a_cidr_block" {
  value = aws_subnet.main_subnet_db_1a.cidr_block
}
output "main_subnet_db_1b_id" {
  value = aws_subnet.main_subnet_db_1b.id
}
output "main_subnet_db_1b_cidr_block" {
  value = aws_subnet.main_subnet_db_1b.cidr_block
}

output "main_subnet_db_group" {
  value = aws_db_subnet_group.main_subnet_db_group.id
}