# Changelog

## 1.5.0

### Removed
- Dropped the `mehulgohil/curl2` provider (and its data source/responses) -
  it hard-failed on any unresponsive endpoint, contradicting the module's
  resilience goal. `external_curl` remains the default; `http` stays as an option.
  NOTE: passing `data_provider = "curl2"` now fails validation.
- Dropped `https://ip.seeip.org` (dead service) and `https://httpbin.org/ip`
  (JSON responses, rate-limited) from the default service list.

### Fixed
- `external_curl.sh` now accepts fractional timeouts (`var.request_timeout`
  values like 500ms -> `0.5s` were silently reset to 5s).
- Timeout validation made portable across `/bin/sh` implementations (busybox
  ash choked on the bash regex).
- `--max-time` is derived from the configured timeout instead of integer math.

### Added
- `getmyip.tftest.hcl`: terraform/opentofu test suite (3 runs) covering the
  default provider, dead-endpoint resilience, and the `http` provider path.
- `.gitignore` for state files, `.terraform/`, and lockfile churn.
- Expanded default service list, all live-validated:
  - IPv4: `ifconfig.co/ip`, `ifconfig.me/ip`, `ifconfig.io/ip` now use their
    plain-text endpoints instead of returning HTML pages (which previously
    let CDN proxy IPs into the vote via X-Forwarded-For headers).
  - IPv6: added `api6.ipify.org`, `api64.ipify.org`,
    `ipv6.myexternalip.com/raw`, `ipv6.wtfismyip.com/text`.

### Housekeeping
- Removed committed `terraform.tfstate`/`.backup` and stale darwin-arm64
  `.terraform/` cache; README regenerated.

### Compatibility
- Validated with Terraform 1.13.x and OpenTofu 1.10.x (`validate` + `test` 3/3).
- Module interface unchanged except `data_provider = "curl2"` is no longer valid.

