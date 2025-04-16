#!/bin/bash

set -euo pipefail


echo "skipping an existing commit"

echo "🔍 Checking for existing builds for commit $BUILDKITE_COMMIT..."

#Fetch builds ran on this commit

response=$(curl -s -H "Authorization: Bearer ${buildkite_api_token}" \
  "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds?commit=${BUILDKITE_COMMIT}")


echo "Response ${response}"


# Extract build numbers from the response
build_numbers=$(echo "$response" | grep -o '"number":[0-9]\+' | grep -o '[0-9]\+')

# Remove 0s as there are few other number 0 in the response
build_numbers=$(echo "$build_numbers" | while read -r number; do
  echo "$number" | sed 's/^0*//'
done)

echo "Build numbers: ${build_numbers}"

# Check if any build number is different from the current build number
for number in $build_numbers; do
  if [ "$number" != "$BUILDKITE_BUILD_NUMBER" ]; then
    echo "✅ Commit $BUILDKITE_COMMIT has already been built in build #$number. Skipping step..."
    exit 1
  fi
done

