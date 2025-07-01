terraform {
  required_version = "~> 1.0"
  required_providers {
    external = {
      version = "~> 2.3.1"
      source  = "hashicorp/external"
    }
    curl2 = {
      version = "~> 1.6"
      source  = "mehulgohil/curl2"
    }
    http = {
      version = "~> 3"
      source  = "hashicorp/http"
    }
  }
}

provider "curl2" {
  timeout_ms = var.request_timeout
  retry {
    retry_attempts = var.retry_attempts
  }
}

# this is the most reliable option due to the fact we can fake response for a broken service url
data "external" "external_curl" {
  for_each = var.data_provider == "external_curl" ? toset(local.service_urls) : []
  program  = ["/bin/sh", "${path.module}/external_curl.sh", each.key, var.retry_attempts, var.request_timeout / 1000]
  query = {
    id = ""
  }
}

# curl2 is the default method
data "curl2" "myip" {
  for_each    = var.data_provider == "curl2" ? toset(local.service_urls) : []
  uri         = each.key
  http_method = "GET"
}

# but we can use http if you prefer
data "http" "myip" {
  for_each           = var.data_provider == "http" ? toset(local.service_urls) : []
  url                = each.key
  method             = "GET"
  request_timeout_ms = var.request_timeout
  retry {
    attempts = var.retry_attempts
  }
}

locals {
  # merge extra with primary list and make sure entries are unique
  service_urls = distinct(concat(var.service_urls, var.extra_service_urls))

  # pick whichever responses we based on the chosen data_provider option
  external_curl_responses = var.data_provider == "external_curl" ? values(data.external.external_curl)[*].result.body : []
  curl2_responses         = var.data_provider == "curl2" ? values(data.curl2.myip)[*].response.body : []
  http_responses          = var.data_provider == "http" ? values(data.http.myip)[*].response_body : []

  # build a list of responses
  service_response_bodies = concat(local.external_curl_responses, local.curl2_responses, local.http_responses)

  # remunge it without whitespace as a list of strings
  split_output = split(",", replace(trimspace(join(",", local.service_response_bodies)), "/\\s/", ""))

  # we test responses for valid v4 or v6
  ipv4_matches = [
    for cidr in local.split_output : cidr
    if can(cidrnetmask("${cidr}/32"))
  ]
  ipv6_matches = [
    for cidr in local.split_output : cidr
    if can(cidrhost("${cidr}/128", 0))
  ]

  # simplified frequency counting - find the most common IP address
  ipv4_frequency_map = {
    for ip in distinct(local.ipv4_matches) :
    ip => length([for match in local.ipv4_matches : match if match == ip])
  }
  ipv4_max_count = length(local.ipv4_frequency_map) > 0 ? max(values(local.ipv4_frequency_map)...) : 0
  ipv4_most_common_response = [
    for ip, count in local.ipv4_frequency_map : ip if count == local.ipv4_max_count
  ]

  # same for ipv6
  ipv6_frequency_map = {
    for ip in distinct(local.ipv6_matches) :
    ip => length([for match in local.ipv6_matches : match if match == ip])
  }
  ipv6_max_count = length(local.ipv6_frequency_map) > 0 ? max(values(local.ipv6_frequency_map)...) : 0
  ipv6_most_common_response = [
    for ip, count in local.ipv6_frequency_map : ip if count == local.ipv6_max_count
  ]

}

# See outputs.tf where we spit out the winners