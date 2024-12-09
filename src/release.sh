#!/bin/bash

set -e

name=$(buildkite-agent meta-data get "release-name")
notes=$(buildkite-agent meta-data get "release-notes")
type=$(buildkite-agent meta-data get "release-type")

echo "Release name chosen $name"

echo "Release notes $notes"

echo "Release type $type"