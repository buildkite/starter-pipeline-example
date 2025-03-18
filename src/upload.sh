#!/bin/bash

set -euo pipefail  # Strict error handling

echo "Uploading artifact..." 

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <yaml-file>" >&2
  exit 1
fi

input_file="$1"

if [[ ! -f "$input_file" ]]; then
  echo "Error: File '$input_file' not found." >&2
  exit 1
fi

pipeline_file=$(mktemp --suffix .yaml --tmpdir pipeline.XXXXXXXXXX)
# shellcheck disable=SC2064
trap 'rm -f "${pipeline_file}"' EXIT  # Ensure cleanup on exit

cp "$input_file" "$pipeline_file"  # Copy input file to temp file

buildkite-agent artifact upload "${pipeline_file}"
buildkite-agent pipeline upload "${pipeline_file}"