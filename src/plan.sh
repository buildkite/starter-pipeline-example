#!/bin/bash

export PS4='$'
terraform init
terraform plan -out=tfplan
terraform show -no-color tfplan > plan.txt
buildkite-agent annotate --style info --context terraform-plan --append < plan.txt
