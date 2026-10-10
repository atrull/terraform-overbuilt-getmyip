# Changelog

## Unreleased

### Removed
- Dropped the `mehulgohil/curl2` provider (and its data source/responses) -
  it hard-failed on any unresponsive endpoint, contradicting the module's
  resilience goal. `external_curl` remains the default; `http` stays as an option.

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

### Housekeeping
- Removed committed `terraform.tfstate`/`.backup` and stale darwin-arm64
  `.terraform/` cache; README regenerated (curl2 references removed).

### Compatibility
- Validated with Terraform 1.13.x and OpenTofu 1.10.x (`validate` + `test` 3/3).
- No interface changes: inputs and outputs are unchanged.
