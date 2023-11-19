# Exit if any of the intermediate steps fail
set -e

export BODY=`curl -s --retry $2 --connect-timeout $3 $1 || echo -n noresponse`
# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg BODY "$BODY" '{"body":$BODY}'