#!/usr/bin/env bash

set -euo pipefail


echo "skipping an existing commit"

echo "🔍 Checking for existing builds for commit $BUILDKITE_COMMIT..."



# Fetch builds for the specified commit
RESPONSE=$(curl -s -H "Authorization: Bearer ${buildkite_api_token}" \
  "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds?commit=${BUILDKITE_COMMIT}")

echo "Response ${RESPONSE}"



# Extract build numbers from the response
BUILD_NUMBERS=$(echo "$RESPONSE" | grep -o '"number":[0-9]\+' | grep -o '[0-9]\+')

echo "Build numbers: ${BUILD_NUMBERS}"

# Check if any build number is different from the current build number
for NUMBER in $BUILD_NUMBERS; do
  if [ "$NUMBER" != "$BUILDKITE_BUILD_NUMBER" ]; then
    echo "✅ Commit $BUILDKITE_COMMIT has already been built in build #$NUMBER. Skipping step..."
    exit 0
  fi
done

