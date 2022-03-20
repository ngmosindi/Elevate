output "main_vpc_id" {
  value = module.network.main_vpc_id
}
output "main_vpc_cidr_block" {
  value = module.network.main_vpc_cidr_block
}

output "app_alb_dns" {
  value = module.app.alb_dns_name
}

output "web_alb_dns" {
  value = module.web.alb_dns_name
}