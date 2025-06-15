#!/bin/bash

# File where the pipeline configuration will be saved
output_file="pipeline.yml"

# Start the pipeline configuration
echo "steps:" > $output_file

# Generate 5 dynamic steps with concurrency
for i in {1..5}
do
  cat <<EOF >> $output_file
  - command: "echo Processing part $i"
    label: ":echo: Echo part $i"
    concurrency_group: 'deploy'
    concurrency: 5
EOF
done

# Upload the generated pipeline configuration to Buildkite
buildkite-agent pipeline upload $output_file

echo "Pipeline configuration uploaded."

