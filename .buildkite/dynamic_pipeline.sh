#!/bin/bash

set -eu

echo "steps:"


# A deploy step only if it's the master branch

if [[ "$BUILDKITE_BRANCH" == "main" ]]; then
  echo "  - wait"
  echo "  - command: \"echo Deploy!\""  
  echo "    label: \":rocket:\""
  echo "  - command: \"echo test!\""  
  echo "    label: \":test:\""

fi