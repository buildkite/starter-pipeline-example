#!/bin/bash

set -euo pipefail


echo "skipping an existing commit"

echo "🔍 Checking for existing builds for commit $BUILDKITE_COMMIT..."

page=1
per_page=100
found=false

while true; do
  # Fetch builds for the specified commit and page
  response=$(curl -s -D - \
    -H "Authorization: Bearer ${buildkite_api_token}" \
    "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds?commit=${BUILDKITE_COMMIT}&page=${page}&per_page=${per_page}")

    # read headers and body
    headers=$(echo "$response" | sed '/^\r$/q')
    body=$(echo "$response" | sed '1,/^\r$/d')

    # Extract build numbers from the response body
    build_numbers=$(echo "$body" | grep -o '"number":[0-9]\+' | grep -o '[0-9]\+')

    # Remove leading zeros from build numbers
    build_numbers=$(echo "$build_numbers" | sed 's/^0*//')

    echo "Build numbers where this commit is built: ${build_numbers}"

    # Check if any build number is different from the current build number
    for number in $build_numbers; do
    if [ "$number" != "$BUILDKITE_BUILD_NUMBER" ]; then
        echo "✅ Commit $BUILDKITE_COMMIT has already been built in build #$number. Skipping step..."
        buildkite-agent annotate "Commit $BUILDKITE_COMMIT has already been built in build #$number. Exiting step..."
        exit 1
    fi
    done

    # Check for the 'next' link in the headers
    next_link=$(echo "$headers" | grep -i '^Link:' | sed -n 's/.*<\([^>]*\)>; rel="next".*/\1/p')

    if [ -z "$next_link" ]; then
        # No more pages
        break
    else
        # Increment page number for the next iteration
        ((page++))
    fi
done
