run "default_external_curl_gets_valid_ipv4" {
  command = plan

  assert {
    condition     = can(cidrhost("${output.ipv4}/32", 0))
    error_message = "ipv4 output is not a valid IPv4 address: ${output.ipv4}"
  }

  assert {
    condition     = output.ipv4_distinct_matches != [] && contains(output.ipv4_distinct_matches, output.ipv4)
    error_message = "The winning ipv4 must appear in the distinct matches list"
  }

  assert {
    condition     = output.service_statistics.total_services_queried == length(var.service_urls)
    error_message = "All default services should have been queried"
  }

  assert {
    condition     = output.service_statistics.failed_responses <= output.service_statistics.total_services_queried
    error_message = "Failed responses count cannot exceed total services queried"
  }
}

run "unresponsive_services_do_not_break_the_run" {
  command = plan

  variables {
    extra_service_urls = [
      "https://nonexistent-host-for-getmyip-tests.invalid",
      "https://unreachable.invalid.somewhere.test/plain",
    ]
  }

  assert {
    condition     = can(cidrhost("${output.ipv4}/32", 0))
    error_message = "A valid ipv4 answer should survive dead endpoints"
  }

  assert {
    condition     = !contains(output.ipv4_all_matches, "noresponse")
    error_message = "'noresponse' placeholders must be filtered out of matches"
  }
}

run "http_provider_gets_valid_ipv4" {
  command = plan

  variables {
    data_provider   = "http"
    # the http provider fails hard on dead endpoints, so use a small
    # IPv4-only list and a generous timeout
    service_urls    = ["https://icanhazip.com", "https://api.ipify.org", "https://checkip.amazonaws.com"]
    request_timeout = 5000
  }

  assert {
    condition     = can(cidrhost("${output.ipv4}/32", 0))
    error_message = "ipv4 output from the http provider is not a valid IPv4 address: ${output.ipv4}"
  }
}
