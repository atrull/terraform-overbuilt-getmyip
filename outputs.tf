
output "ipv4_matches" {
  value = local.ipv4_matches
}

output "ipv6_matches" {
  value = local.ipv6_matches
}

output "ipv4_most_common_response" {
  value = join("", local.ipv4_most_common_response)
}

output "ipv6_most_common_response" {
  value = join("", local.ipv6_most_common_response)
}