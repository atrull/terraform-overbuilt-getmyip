variable "myip_service_urls" {
  default = [
    "https://api.seeip.org",
    "https://ipinfo.io/ip",
    "https://ifconfig.co",
    "https://icanhazip.com",
    "https://api.ipify.org",
    "https://ifconfig.me",
    "https://ipecho.net/plain",
    "https://ifconfig.io",
    "http://eth0.me/",
    "https://ident.me",
    "https://ipv4.ident.me",
  ]
}

variable "data_provider" {
  default     = "curl"
  description = "(curl) or (http) provider are both supported."
}