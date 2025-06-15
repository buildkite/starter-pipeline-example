#!/bin/bash

# Temporary file to hold the pipeline configuration
temp_pipeline="dynamic-pipeline.yml"

# Create the trigger step for another pipeline
cat <<EOF > $temp_pipeline
---
steps:
- async: true
  build:
    env:
      WORKLOAD: |
        {"type": "fix-test",
         "metadata": {
           "build_number": "1020507",
           "job_id": "0194b4c0-532c-479e-b4c7-e770119510da",
           "job_label": ":buildkite: mandatory_checks - :exclamation: run oaipkg checks - @shantanu",
         }
        }
  label: ":hammer: Trigger fixing test failures asynchronously @miz"
  trigger: metadata-starter
  soft_fail: true
EOF

# Upload the dynamically generated pipeline configuration
buildkite-agent pipeline upload $temp_pipeline

# Optional: Sleep for a certain period if needed to observe the behavior
sleep 3

# Fail the script intentionally
echo "This step will intentionally fail."
exit 1
