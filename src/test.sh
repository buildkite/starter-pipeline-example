  #!/bin/bash
  set -euo pipefail

  NAME=$(buildkite-agent meta-data get environment-type)

  IFS=', ' read -r -a array <<< "$NAME"
  echo "${array[0]}"