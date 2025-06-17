# Overbuilt myip module

## What it does

This module polls a series of fairly well known but occasionally unreliable 'what is my ip' services. It then produces the most common response that is a valid ipv4 or ipv6 address (both outputs are separately provided).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_curl2"></a> [curl2](#requirement\_curl2) | ~> 1.6 |
| <a name="requirement_external"></a> [external](#requirement\_external) | ~> 2.3.1 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_curl2"></a> [curl2](#provider\_curl2) | 1.6.1 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.5 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [curl2_curl2.myip](https://registry.terraform.io/providers/mehulgohil/curl2/latest/docs/data-sources/curl2) | data source |
| [external_external.external_curl](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_provider"></a> [data\_provider](#input\_data\_provider) | `curl2` or `http` providers are also supported - we recommend `external_curl` because it handles failure better | `string` | `"external_curl"` | no |
| <a name="input_extra_service_urls"></a> [extra\_service\_urls](#input\_extra\_service\_urls) | Put your own in here if you want extra ones, this gets merged with the `service_urls` list | `list(string)` | `[]` | no |
| <a name="input_request_timeout"></a> [request\_timeout](#input\_request\_timeout) | Request timeout in milliseconds | `number` | `500` | no |
| <a name="input_retry_attempts"></a> [retry\_attempts](#input\_retry\_attempts) | Request retries | `number` | `1` | no |
| <a name="input_service_urls"></a> [service\_urls](#input\_service\_urls) | List of urls to use for getting our IP | `list(string)` | <pre>[<br/>  "https://ipinfo.io/ip",<br/>  "https://ifconfig.co",<br/>  "https://icanhazip.com",<br/>  "https://api.ipify.org",<br/>  "https://ifconfig.me",<br/>  "https://ipecho.net/plain",<br/>  "https://ifconfig.io",<br/>  "https://ident.me",<br/>  "https://ipv4.ident.me",<br/>  "https://checkip.amazonaws.com"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4"></a> [ipv4](#output\_ipv4) | The most common ipv4 response |
| <a name="output_ipv4_all_matches"></a> [ipv4\_all\_matches](#output\_ipv4\_all\_matches) | List of all ipv4 matches (informational/testing) |
| <a name="output_ipv4_distinct_matches"></a> [ipv4\_distinct\_matches](#output\_ipv4\_distinct\_matches) | List of unique ipv4 matches |
| <a name="output_ipv6"></a> [ipv6](#output\_ipv6) | The most common ipv6 response |
| <a name="output_ipv6_all_matches"></a> [ipv6\_all\_matches](#output\_ipv6\_all\_matches) | List of all ipv6 matches (informational/testing) |
| <a name="output_ipv6_distinct_matches"></a> [ipv6\_distinct\_matches](#output\_ipv6\_distinct\_matches) | List of unique ipv6 matches |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Providers and their Limitations : An explanation.

The goal of this module is to provide a valid-enough answer even when the internet does what the internet does, which is to be flaky and broken somewhere, sometime.

Neither the `curl2` nor `http` providers are perfectly suited to the internet since they will fail a run if the url doesn't respond and/or the url doesn't resolve. The `curl2` provider is slightly more reliable than the `http` provider. This failure mode makes sense if it's a critical part of your terraform..

Both of `curl2` and `http` providers are provided as a matter of them being possibly better in the future if/when they have some `ignore_failure` options.

Since we're aggregating results to achieve a 'most common' response it frankly shouldn't matter if one of the endpoints in the list fails to respond - we will have gathered enough data to make a good response. Let the build roll on!

As such we implement an `external_curl` using the `external` provider and a shim script `external_curl.sh`, which will survive a truly non-resolving non-responsive endpoint by faking the response data, which will be filtered out later by our `ipv4_matches` and `ipv6_matches` filters.

## Authors

Alex Trull (firstname@lastname.org)

## License

BSD-3

## Inspiration

The failed builds because the myip service I had chosen wasn't working or there was a routing error in the pipeline. I owe it all to you!

## Additional information for users from all ip addresses

* I am very fond of you all.