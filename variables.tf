variable "service_urls" {
  default = [
    "https://api.seeip.org",
    "https://ipinfo.io/ip",
    "https://ifconfig.co",
    "https://icanhazip.com",
    "https://api.ipify.org",
    "https://ifconfig.me",
    "https://ipecho.net/plain",
    "https://ifconfig.io",
    "https://ident.me",
    "https://ipv4.ident.me",
  ]
  type        = list(string)
  description = "List of urls to use for getting our IP"
}

variable "request_timeout" {
  default     = 500
  type        = number
  description = "Request timeout in milliseconds"
}

variable "retry_attempts" {
  default     = 0
  type        = number
  description = "Request retries"
}

variable "extra_service_urls" {
  default     = []
  type        = list(string)
  description = "Put your own in here if you want extra ones, this gets merged with the `service_urls` list"
}

variable "data_provider" {
  default     = "curl2"
  type        = string
  description = "`curl2` or `http` providers are both supported - we recommend `curl2`"
}