
#!/bin/bash

set -e


touch foo.txt
buildkite-agent artifact upload "foo.txt"