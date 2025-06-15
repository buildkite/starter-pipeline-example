#!/bin/bash


if [ -n "$SEND_IT" ]; then
  echo "Setting the variable to true"
  export SEND_NOTIFICATION='true'
else
  echo "Not sending notifications."
fi
