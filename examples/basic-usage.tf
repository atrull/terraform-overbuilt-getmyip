# Basic usage example
module "my_ip" {
  source = "atrull/getmyip/overbuilt"
}

output "my_public_ip" {
  value = module.my_ip.ipv4
}

output "my_public_ipv6" {
  value = module.my_ip.ipv6
}