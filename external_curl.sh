#!/bin/bash
# Exit if any of the intermediate steps fail
set -e

# Input validation
URL="$1"
RETRY_ATTEMPTS="$2"
TIMEOUT_SEC="$3"

# Validate URL format (basic check for http/https)
if [[ ! "$URL" =~ ^https?:// ]]; then
    echo '{"body":"noresponse","error":"invalid_url"}' | jq .
    exit 0
fi

# Validate retry attempts (must be numeric and >= 0)
if ! [[ "$RETRY_ATTEMPTS" =~ ^[0-9]+$ ]] || [ "$RETRY_ATTEMPTS" -lt 0 ]; then
    RETRY_ATTEMPTS=1
fi

# Validate timeout (must be numeric and > 0)
if ! [[ "$TIMEOUT_SEC" =~ ^[0-9]+$ ]] || [ "$TIMEOUT_SEC" -le 0 ]; then
    TIMEOUT_SEC=5
fi

# Perform the curl request with enhanced security and reliability
BODY=$(curl -s \
    --retry "$RETRY_ATTEMPTS" \
    --connect-timeout "$TIMEOUT_SEC" \
    --max-time "$((TIMEOUT_SEC + 5))" \
    --fail \
    --location \
    --user-agent "overbuilt-getmyip/1.0" \
    "$URL" 2>/dev/null || echo -n "noresponse")

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted and escaped
jq -n --arg BODY "$BODY" '{"body":$BODY}'