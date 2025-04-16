#!/usr/bin/env bash

set -euo pipefail


echo "skipping an existing commit"


COMMIT=${BUILDKITE_COMMIT}
echo "🔍 Checking for existing builds for commit $COMMIT..."



# Fetch builds for the specified commit
RESPONSE=$(curl -s -H "Authorization: Bearer ${buildkite_api_token}" \
  "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds?commit=${COMMIT}")

echo "Response ${RESPONSE}"



BUILD_IDS=()
while [[ "$RESPONSE" =~ \"id\":\"([^\"]+)\" ]]; do
  BUILD_IDS+=("${BASH_REMATCH[1]}")
  RESPONSE="${RESPONSE#*"${BASH_REMATCH[0]}"}"  # Remove the matched part to find the next occurrence
done
echo "Build IDs: $BUILD_IDS"

for ID in $BUILD_IDS; do
  if [ "$ID" != "$BUILDKITE_BUILD_ID" ]; then
    echo "✅ Commit $COMMIT has already been built in build ID $ID. Skipping step..."
    buildkite-agent annotate  "Skipping build for commit $COMMIT as it has already been built." 

    exit 1
  fi
done


