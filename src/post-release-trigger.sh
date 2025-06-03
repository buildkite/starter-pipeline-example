#!/bin/bash

## Call the Buildkite create build endpoint to trigger a post-release-verify pipeline build
curl -H "Authorization: Bearer $TOKEN" -X POST "https://api.buildkite.com/v2/organizations/my-example/post-release-verify/builds" \
-H "Content-Type: application/json" \
-d '{
  "commit": "abcd0b72a1e580e90712cdd9eb26d3fb41cd09c8",
  "branch": "master",
  "message": "Deployment post verify trigger",
  "author": {
    "name": "John Doe",
    "email": "jdoe@exampler-email.com "
  },
}'