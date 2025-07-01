# Examples

This directory contains example usage patterns for the overbuilt-getmyip module.

## Files

- **basic-usage.tf** - Simple usage with default settings
- **custom-settings.tf** - Example with custom timeout, retry settings, and additional services
- **aws-security-group.tf** - Real-world example using the module to create AWS security group rules

## Running Examples

```bash
cd examples
terraform init
terraform plan
terraform apply
```

## Common Patterns

### Quick IP Detection
For fast builds where you just need the IP quickly:
```hcl
module "quick_ip" {
  source = "path/to/overbuilt-getmyip"
  request_timeout = 1000  # 1 second
  retry_attempts  = 0     # no retries
}
```

### High Reliability
For maximum reliability in unstable network conditions:
```hcl
module "reliable_ip" {
  source = "path/to/overbuilt-getmyip"
  request_timeout = 5000  # 5 seconds
  retry_attempts  = 5     # more retries
  data_provider   = "external_curl"  # most reliable
}
```

### Multiple Source IPs
If you have connection hashing and want to see all your source IPs:
```hcl
module "all_ips" {
  source = "path/to/overbuilt-getmyip"
}

output "all_detected_ips" {
  value = module.all_ips.ipv4_distinct_matches
}
```