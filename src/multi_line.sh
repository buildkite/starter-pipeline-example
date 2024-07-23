#!/bin/bash

set -e

echo "Downloading"

pwd
ls


if buildkite-agent artifact search foo.txt; then
  echo "Artifact found"
fi


echo "Downloaded"


if buildkite-agent artifact search artifact.txt; then
  echo "Artifact found"
  < do your download here>
fi