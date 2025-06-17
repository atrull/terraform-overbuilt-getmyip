output "ipv4" {
  value       = join("", local.ipv4_most_common_response)
  description = "The most common ipv4 response"
}

output "ipv6" {
  value       = join("", local.ipv6_most_common_response)
  description = "The most common ipv6 response"
}

output "ipv4_distinct_matches" {
  value       = distinct(local.ipv4_matches)
  description = "List of unique ipv4 matches"
}

output "ipv6_distinct_matches" {
  value       = distinct(local.ipv6_matches)
  description = "List of unique ipv6 matches"
}

output "ipv4_all_matches" {
  value       = local.ipv4_matches
  description = "List of all ipv4 matches (informational/testing)"
}

output "ipv6_all_matches" {
  value       = local.ipv6_matches
  description = "List of all ipv6 matches (informational/testing)"
}
