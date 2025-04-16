#!/bin/bash

set -euo pipefail

echo "🔍 Checking for existing builds for commit $BUILDKITE_COMMIT..."

# Initialize the URL for the first page
url="https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds?commit=${BUILDKITE_COMMIT}&per_page=100"

while [ -n "$url" ]; do
    # Fetch the response headers and body
    response=$(curl -s -D - -H "Authorization: Bearer ${buildkite_api_token}" "$url")

    # Separate headers and body
    headers=$(echo "$response" | sed '/^\r$/q')
    body=$(echo "$response" | sed '1,/^\r$/d')

    # Extract build numbers from the response body
    build_numbers=$(echo "$body" | grep -o '"number":[0-9]\+' | grep -o '[0-9]\+')

    # Remove leading zeros from build numbers
    build_numbers=$(echo "$build_numbers" | sed 's/^0*//')

    echo "Build numbers where this commit is built: ${build_numbers}"

    # Check if any build number is different from the current build number
    for number in $build_numbers; do
        echo "Checking build number: $number"
        if [ "$number" != "$BUILDKITE_BUILD_NUMBER" ]; then
            echo "✅ Commit $BUILDKITE_COMMIT has already been built in build #$number. Skipping step..."
            buildkite-agent annotate "Commit $BUILDKITE_COMMIT has already been built in build #$number. Cancelling the build..."
            curl -H "Authorization: Bearer $buildkite_api_token" \
                 -X PUT "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds/$BUILDKITE_BUILD_NUMBER/cancel"
            exit 0
        fi
    done

    echo "No other builds found for commit $BUILDKITE_COMMIT."
    echo "Checking for next page of results..."

    # Extract the Link header line
    link_header=$(echo "$headers" | grep -i '^Link:')
    echo "Link header: $link_header"

    # Use sed to extract the URL with rel="next"
    next_link=$(echo "$link_header" | sed -n 's/.*<\([^>]*\)>; rel="next".*/\1/p')
    echo "Next link: $next_link"

    # Update the URL for the next iteration or break if no next link
    if [ -n "$next_link" ]; then
        url="$next_link"
    fi
done
