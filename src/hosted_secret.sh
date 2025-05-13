#!/bin/bash

set -e

pwd

echo "secret"
echo "$(buildkite-agent secret get API_TOKEN)"

echo "$(buildkite-agent secret get AWS_ACCOUNT_ID)"

SECRET_VAR=$(buildkite-agent secret get API_TOKEN)

export SECRET_VAR=$SECRET_VAR

ACCOUNT_ID=$(buildkite-agent secret get AWS_ACCOUNT_ID)

export ACCOUNT_ID=$ACCOUNT_ID

echo "secret var is $SECRET_VAR"
echo "account id is $ACCOUNT_ID"

if [ -z "$SECRET_VAR" ]; then
echo "API_TOKEN is not set"
exit 1
fi

if [ -z "$ACCOUNT_ID" ]; then
echo "API_TOKEN is not set"
exit 1
fi