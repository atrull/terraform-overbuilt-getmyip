# Example with custom settings
module "my_ip_custom" {
  source  = "atrull/getmyip/overbuilt"

  # Use faster timeout for quick builds
  request_timeout = 2000  # 2 seconds
  retry_attempts  = 3

  # Add your own preferred services
  extra_service_urls = [
    "https://api.myip.com",
    "https://ipv4.icanhazip.com"
  ]

  # Use different provider (less reliable but sometimes preferred)
  data_provider = "http"
}

output "ip_with_statistics" {
  value = {
    ipv4              = module.my_ip_custom.ipv4
    ipv6              = module.my_ip_custom.ipv6
    service_stats     = module.my_ip_custom.service_statistics
    all_ipv4_detected = module.my_ip_custom.ipv4_distinct_matches
  }
}