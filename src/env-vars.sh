#!/bin/bash
set -euo pipefail
# This saves really?
echo "Importing the env vars"
env_vars=$(<"$BUILDKITE_ENV_FILE")
# Declare a bash array for env_vars
#declare -A env_vars
#env_vars=(foo bar)

env_vars+=(
    "BUILDKITE_AGENT_ACCESS_TOKEN"=\"${BUILDKITE_AGENT_ACCESS_TOKEN_SUBAGENT:-$BUILDKITE_AGENT_ACCESS_TOKEN}\"
    "BUILDKITE_BUILD_PATH"=\"${BUILDKITE_BUILD_PATH_SUBAGENT:-$BUILDKITE_BUILD_PATH}\"
    "BUILDKITE_HOOKS_PATH"=\"${BUILDKITE_HOOKS_PATH_SUBAGENT:-$BUILDKITE_HOOKS_PATH}\"
    "BUILDKITE_PLUGINS_PATH"=\"${BUILDKITE_PLUGINS_PATH_SUBAGENT:-$BUILDKITE_PLUGINS_PATH}\"
    "BUILDKITE_PLUGIN_VALIDATION"=\"${BUILDKITE_PLUGIN_VALIDATION_SUBAGENT:-$BUILDKITE_PLUGIN_VALIDATION}\"
    "BUILDKITE_LOCAL_HOOKS_ENABLED"=\"${BUILDKITE_LOCAL_HOOKS_ENABLED_SUBAGENT:-$BUILDKITE_LOCAL_HOOKS_ENABLED}\"
    "BUILDKITE_SSH_KEYSCAN"=\"${BUILDKITE_SSH_KEYSCAN_SUBAGENT:-$BUILDKITE_SSH_KEYSCAN}\"
    "BUILDKITE_AGENT_DEBUG"=\"${BUILDKITE_AGENT_DEBUG_SUBAGENT:-$BUILDKITE_AGENT_DEBUG}\"
)

echo "Print the env_vars array with all elements"
echo ${env_vars[@]}
echo "--------------------------------------------"

export_command=""
for env_var in "${env_vars[@]}"; do
  export_command+="export $env_var;"
done

zsh -c "echo $export_command;"

