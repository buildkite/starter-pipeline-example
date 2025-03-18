#!/bin/bash

set -euo pipefail  # Strict error handling

echo "Uploading artifact..." 


pwd
ls -la
pipeline_file= pipeline_upload.yml
# shellcheck disable=SC2064
trap 'rm -f "${pipeline_file}"' EXIT  # Ensure cleanup on exit

cp "$input_file" "$pipeline_file"  # Copy input file to temp file

buildkite-agent artifact upload "${pipeline_file}"
buildkite-agent pipeline upload "${pipeline_file}"