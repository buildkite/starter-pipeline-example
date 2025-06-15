#!/bin/bash

action=${1:-}

if [[ "$action" == "collect" ]]; then
  parallel_numbers=$(buildkite-agent meta-data get steps-count)
  echo "Fetching $parallel_numbers parallel numbers..."

  for ((i = 0; i < parallel_numbers; i++)); do
    (
      set -x
      buildkite-agent meta-data get "generated-number::$i"
    )
    echo
  done
else
  (
    set -x
    BUILDKITE_JOB_ID="01926976-5428-4b57-8b0e-3cd6875b140a"
    buildkite-agent meta-data get --job $BUILDKITE_JOB_ID generated-number
  )
fi
echo
echo
