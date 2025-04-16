#!/usr/bin/env bash

set -euo pipefail


echo "skipping an existing commit"

echo "🔍 Checking for existing builds for commit $BUILDKITE_COMMIT..."



# Fetch builds for the specified commit
RESPONSE=$(curl -s -H "Authorization: Bearer ${buildkite_api_token}" \
  "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds?commit=${BUILDKITE_COMMIT}")

echo "Response ${RESPONSE}"



# Extract build IDs using pattern matching
BUILD_IDS=()
while [[ "$RESPONSE" =~ \"id\":\"([^\"]+)\" ]]; do
  BUILD_IDS+=("${BASH_REMATCH[1]}")
  echo "Build ID in loop: ${BASH_REMATCH[1]}"
  RESPONSE="${RESPONSE#*"${BASH_REMATCH[0]}"}"  # Remove the matched part to find the next occurrence
done

echo "Build IDs: ${BUILD_IDS[*]}"

# Loop through the extracted build IDs
for ID in "${BUILD_IDS[@]}"; do
  if [ "$ID" != "$BUILDKITE_BUILD_ID" ]; then
    echo "✅ Commit $BUILDKITE_COMMIT has already been built in build ID $ID. Skipping step..."
    buildkite-agent annotate "Skipping build for commit $BUILDKITE_COMMIT as it has already been built."
    exit 1
  fi
done

