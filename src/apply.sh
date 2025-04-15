#!/bin/bash

export PS4='$'

terraform init
terraform apply -auto-approve