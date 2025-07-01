variable "service_urls" {
  default = [
    # IPv4/general services
    "https://ipinfo.io/ip",
    "https://ifconfig.co",
    "https://icanhazip.com",
    "https://api.ipify.org",
    "https://ifconfig.me",
    "https://ipecho.net/plain",
    "https://ifconfig.io",
    "https://ident.me",
    "https://checkip.amazonaws.com",
    "https://httpbin.org/ip",
    "https://myexternalip.com/raw",
    "https://wtfismyip.com/text",
    "https://ip.seeip.org",
    "https://curlmyip.net",
    "https://ipv4.icanhazip.com",
    # IPv6-specific services (will work in IPv6-enabled environments)
    "https://ipv6.icanhazip.com",
    "https://ipv6.ident.me",
    "https://v6.ident.me",
  ]
  type        = list(string)
  description = "List of urls to use for getting our IP (includes both IPv4 and IPv6 services)"
}

variable "extra_service_urls" {
  default     = []
  type        = list(string)
  description = "Put your own in here if you want extra ones, this gets merged with the `service_urls` list"
}

variable "request_timeout" {
  default     = 500
  type        = number
  description = "Request timeout in milliseconds"
  validation {
    condition     = var.request_timeout > 0 && var.request_timeout <= 30000
    error_message = "Request timeout must be between 1 and 30000 milliseconds."
  }
}

variable "retry_attempts" {
  default     = 1
  type        = number
  description = "Request retries"
  validation {
    condition     = var.retry_attempts >= 0 && var.retry_attempts <= 10
    error_message = "Retry attempts must be between 0 and 10."
  }
}

variable "data_provider" {
  default     = "external_curl"
  type        = string
  description = "`curl2` or `http` providers are also supported - we recommend `external_curl` because it handles failure better"
  validation {
    condition     = contains(["external_curl", "curl2", "http"], var.data_provider)
    error_message = "Data provider must be one of: external_curl, curl2, http."
  }
}