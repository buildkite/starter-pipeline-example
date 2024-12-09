#!/bin/bash

set -e

if [ -z "$build" ]; then
  build="foo"
fi


echo "steps:"
    echo " - label: "build""
    echo "   command: echo "Building $build""