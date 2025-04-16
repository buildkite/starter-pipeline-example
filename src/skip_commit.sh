#!/usr/bin/env bash

set -euo pipefail


echo "skipping an existing commit"


COMMIT=${BUILDKITE_COMMIT}
echo "🔍 Checking for existing builds for commit $COMMIT..."



# Fetch builds for the specified commit
RESPONSE=$(curl -s -H "Authorization: Bearer ${buildkite_api_token}" \
  "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds?commit=${COMMIT}")

echo "Response ${RESPONSE}"

# Count the number of occurrences of the "number" field in the JSON response
BUILD_COUNT=$(echo "$RESPONSE" | grep -o '"number":' | wc -l)

# extract build IDs
BUILD_IDS=$(echo "$RESPONSE" | grep -o '"id":"[^"]\+"' | cut -d':' -f2 | tr -d '"')


for ID in $BUILD_IDS; do
  if [ "$ID" != "$CURRENT_BUILD_ID" ]; then
    echo "✅ Commit $COMMIT has already been built in build ID $ID. Skipping step..."
    buildkite-agent annotate  "Skipping build for commit $COMMIT as it has already been built." 

    exit 1
  fi
done


