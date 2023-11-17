terraform {
  required_providers {
    curl = {
      version = "1.0.2"
      source  = "anschoewe/curl"
    }
  }
}

# curl is the default method
data "curl" "myip" {
  for_each    = var.data_provider == "curl" ? toset(var.myip_service_urls) : []
  http_method = "GET"
  uri         = each.key
}

# but we can use http if you prefer
data "http" "myip" {
  for_each           = var.data_provider == "http" ? toset(var.myip_service_urls) : []
  url                = each.key
  method             = "GET"
  request_timeout_ms = 500
}

locals {

  # build a list of responses
  service_response_bodies = var.data_provider == "curl" ? values(data.curl.myip)[*].response : values(data.http.myip)[*].response_body

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

  # what follows is a really long winded version of uniq -c | sort -n
  ipv4_index_list    = [for index, item in local.ipv4_matches : length([for i in slice(local.ipv4_matches, 0, index + 1) : i if i == item])]
  ipv4_joined_index  = zipmap(local.ipv4_matches, local.ipv4_index_list)
  ipv4_reverse_index = { for k, v in local.ipv4_joined_index : v => k... }
  ipv4_most_common_response = local.ipv4_reverse_index != {} ? lookup(
    local.ipv4_reverse_index,
    element(
      sort(keys(local.ipv4_reverse_index)),
      length(local.ipv4_reverse_index) - 1
    )
  ) : []

  # uniq -c | sort -n again but for ipv6
  ipv6_index_list    = [for index, item in local.ipv6_matches : length([for i in slice(local.ipv6_matches, 0, index + 1) : i if i == item])]
  ipv6_joined_index  = zipmap(local.ipv6_matches, local.ipv6_index_list)
  ipv6_reverse_index = { for k, v in local.ipv6_joined_index : v => k... }
  ipv6_most_common_response = local.ipv6_reverse_index != {} ? lookup(
    local.ipv6_reverse_index,
    element(
      sort(keys(local.ipv6_reverse_index)),
      length(local.ipv6_reverse_index) - 1
    )
  ) : []

}

# See outputs.tf for where we spit out the winners