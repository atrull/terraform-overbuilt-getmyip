
output "ipv4_all_matches" {
  value = local.ipv4_matches
}

output "ipv6_all_matches" {
  value = local.ipv6_matches
}

output "ipv4" {
  value = join("", local.ipv4_most_common_response)
}

output "ipv6" {
  value = join("", local.ipv6_most_common_response)
}