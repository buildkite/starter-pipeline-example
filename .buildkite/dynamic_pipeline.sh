#!/bin/bash

set -eu

echo "steps:"


# A deploy step only if it's the master branch

if [[ "$BUILDKITE_BRANCH" == "main" ]]; then
  cat << EOF


steps:
  - label: ":rocket: Trigger Pipeline [baseimage]"
    env:
      AUTHELIA_RELEASE: "${BUILDKITE_MESSAGE}"
      BUILDKITE_PULL_REQUEST: "${BUILDKITE_PULL_REQUEST}"
      BUILDKITE_PULL_REQUEST_BASE_BRANCH: "${BUILDKITE_PULL_REQUEST_BASE_BRANCH}"
      BUILDKITE_PULL_REQUEST_REPO: "${BUILDKITE_PULL_REQUEST_REPO}"
    command: echo "hellp"

EOF

fi