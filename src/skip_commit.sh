#!/usr/bin/env bash

set -euo pipefail


echo "skipping an existing commit"


COMMIT=${BUILDKITE_COMMIT}
echo "🔍 Checking for existing builds for commit $COMMIT..."



BUILDS=$(curl -s -H "Authorization: Bearer ${buildkite_api_token}" \
  "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds?commit=${COMMIT}" \
  | jq '. | length')

if [[ "$BUILDS" -gt 0 ]]; then
  echo "✅ Commit $COMMIT has already been built. Skipping step..."
  buildkite-agent annotate \
    --style "info" \
    --context "skip_commit" \
    --message "Skipping build for commit $COMMIT as it has already been built." \
    "${BUILDKITE_BUILD_ID}"
  exit 0
else
  echo "🚀 No previous build found for commit $COMMIT. Proceeding..."
fi