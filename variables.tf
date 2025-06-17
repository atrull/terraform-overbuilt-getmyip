variable "service_urls" {
  default = [
    "https://ipinfo.io/ip",
    "https://ifconfig.co",
    "https://icanhazip.com",
    "https://api.ipify.org",
    "https://ifconfig.me",
    "https://ipecho.net/plain",
    "https://ifconfig.io",
    "https://ident.me",
    "https://ipv4.ident.me",
    "https://checkip.amazonaws.com",
  ]
  type        = list(string)
  description = "List of urls to use for getting our IP"
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
}

variable "retry_attempts" {
  default     = 1
  type        = number
  description = "Request retries"
}

variable "data_provider" {
  default     = "external_curl"
  type        = string
  description = "`curl2` or `http` providers are also supported - we recommend `external_curl` because it handles failure better"
}