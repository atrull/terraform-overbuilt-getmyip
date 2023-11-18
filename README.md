# Overbuilt myip module

## What it does:

This module polls a series of fairly well known but occasionally unreliable 'what is my ip' services. It then produces the most common response that is a valid ipv4 or ipv6 address (both outputs are separately provided).

We support two providers - `curl` and `http`. `curl` is the default provider because it has better failure handling whereas `http` provider will fail a plan/apply if the endpoint doesn't respond.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_curl"></a> [curl](#requirement\_curl) | ~> 1.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_curl"></a> [curl](#provider\_curl) | 1.0.2 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [curl_curl.myip](https://registry.terraform.io/providers/anschoewe/curl/latest/docs/data-sources/curl) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_provider"></a> [data\_provider](#input\_data\_provider) | `curl` or `http` providers are both supported - we recommend `curl` | `string` | `"curl"` | no |
| <a name="input_extra_service_urls"></a> [extra\_service\_urls](#input\_extra\_service\_urls) | Put your own in here if you want extra ones, this gets merged with the `service_urls` list | `list` | `[]` | no |
| <a name="input_service_urls"></a> [service\_urls](#input\_service\_urls) | List of urls to use for getting our IP | `list` | <pre>[<br>  "https://api.seeip.org",<br>  "https://ipinfo.io/ip",<br>  "https://ifconfig.co",<br>  "https://icanhazip.com",<br>  "https://api.ipify.org",<br>  "https://ifconfig.me",<br>  "https://ipecho.net/plain",<br>  "https://ifconfig.io",<br>  "http://eth0.me/",<br>  "https://ident.me",<br>  "https://ipv4.ident.me"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4"></a> [ipv4](#output\_ipv4) | n/a |
| <a name="output_ipv4_all_matches"></a> [ipv4\_all\_matches](#output\_ipv4\_all\_matches) | n/a |
| <a name="output_ipv6"></a> [ipv6](#output\_ipv6) | n/a |
| <a name="output_ipv6_all_matches"></a> [ipv6\_all\_matches](#output\_ipv6\_all\_matches) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
