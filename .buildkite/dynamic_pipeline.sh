#!/bin/bash
set -euo pipefail

cat <<YAML
steps:
  - label: "trigger"
    command:
      - |
        cat <<EOF | buildkite-agent pipeline upload
        steps:
          - label: "blah"
            command: echo hello
        EOF

  - label: "finisher"
    depends_on: "trigger"
    command: echo "i am done"
YAML
