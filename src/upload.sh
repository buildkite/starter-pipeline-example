#!/bin/bash

set -e

echo "uploading artifact" 


pipeline_file=$(mktemp --suffix .yaml --tmpdir pipeline.XXXXXXXXXX)
# shellcheck disable=SC2064
trap "rm -rf \"${pipeline_file}\"" EXIT
local yaml_file
yaml_file="$("$@")"

if [[ -n "${yaml_file}" ]]; then

  echo "${yaml_file}" > "${pipeline_file}"
  buildkite-agent artifact upload "${pipeline_file}"
  buildkite-agent pipeline upload "${pipeline_file}"
fi

