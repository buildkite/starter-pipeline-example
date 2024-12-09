#!/bin/bash

set -e
shell_event_handler() {
    sleep 70
    echo "inside event handler"
    echo "${1} received."

    case "${1}" in
        "SIGTERM")
            exit 143
            ;;
        "SIGHUP")
            exit 129
            ;;
        "SIGINT")
            exit 130
            ;;
        "SIGKILL")
            exit 137
            ;;
        "SIGQUIT")
            exit 131
            ;;
        *)
            exit 1
            ;;
    esac
}

trap 'shell_event_handler SIGTERM' SIGTERM
trap 'shell_event_handler SIGHUP' SIGHUP
trap 'shell_event_handler SIGINT' SIGINT
trap 'shell_event_handler SIGKILL' SIGKILL
trap 'shell_event_handler SIGQUIT' SIGQUIT

 echo "outside event handler"
 sleep 70

...
pulumi up -r --skip-preview --stack calibrate/${project_name}/${environment}-${service_name} \
    --config-file "${workspace_dir}/${config_path}/Pulumi.${environment}.yaml"

if [ $? -ne 0 ]; then
  echo "error occurred when running pulumi command for ${project_name}"
  exit 1
fi