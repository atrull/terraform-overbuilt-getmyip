output "ipv4" {
  value       = try(distinct(local.ipv4_most_common_response)[0], "")
  description = "The most common ipv4 response"
}

output "ipv6" {
  value       = try(distinct(local.ipv6_most_common_response)[0], "")
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

output "ipv4_frequency_map" {
  value       = local.ipv4_frequency_map
  description = "Map of IPv4 addresses to their frequency count"
}

output "ipv6_frequency_map" {
  value       = local.ipv6_frequency_map
  description = "Map of IPv6 addresses to their frequency count"
}

output "service_statistics" {
  value = {
    total_services_queried = length(local.service_urls)
    total_responses        = length(local.service_response_bodies)
    ipv4_responses         = length(local.ipv4_matches)
    ipv6_responses         = length(local.ipv6_matches)
    failed_responses       = length([for body in local.service_response_bodies : body if body == "noresponse"])
  }
  description = "Statistics about service responses"
}
