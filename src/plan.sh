#!/bin/bash
set -euo pipefail

terraform init
terraform plan -out=tfplan
terraform show -no-color tfplan > plan.txt
buildkite-agent annotate --style info --context terraform-plan --append < plan.txt
