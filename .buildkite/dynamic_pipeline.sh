#!/bin/bash

set -euo pipefail





cat <<YAML
steps:
  - label: "trigger"
    id: trigger
      cat <<EOF | buildkite-agent pipeline upload
        steps:
          - label: blah
            depends_on: ~
            command: echo hello
      EOF
    sleep 10
      
  - label: "finisher"
    depends_on: trigger
    command: echo "i am done"
YAML
done    