#!/bin/bash

set -eu

echo "steps:"


# A deploy step only if it's the master branch


cat << EOF


steps:
  - label: ":rocket: PR with base change to main Trigger Pipeline [baseimage]"
    env:
      AUTHELIA_RELEASE: "${BUILDKITE_MESSAGE}"
      BUILDKITE_PULL_REQUEST: "${BUILDKITE_PULL_REQUEST}"
      BUILDKITE_PULL_REQUEST_BASE_BRANCH: "${BUILDKITE_PULL_REQUEST_BASE_BRANCH}"
      BUILDKITE_PULL_REQUEST_REPO: "${BUILDKITE_PULL_REQUEST_REPO}"
      PROVIDER: "controls_direct_drive_sim_domain_variations"
      VAULT_ROLE: "simulation-prod-buildkite"
      AWS_ACCOUNT_NAME: "simulation-prod"
      SIM_WAIT_TIMEOUT: "480"
      SIM_EXTRA_LJJ_ARGS: "--calibrated_timings config/dev/fastest_possible_timings.cfg --output_log_ttl ninety_days"
      POSE_BIAS_SET_VERSION: "13"
      POSE_DELAY_SET_VERSION: "16"
      SIDE_WIND_GUSTS_SET_VERSION: "11"
      DEFAULT_POSE_BIAS_SET_VERSION: "13"
      DEFAULT_POSE_DELAY_SET_VERSION: "16"
      UNIFORM_ROAD_GRADE_SET_VERSION: "10"
      POSE_BIAS_TEST_DRIVE_REPORT_NAME: "Pose Bias - Control Structured Test"
      TRACTOR_TIRE_BLOWOUT_SET_VERSION: "4"
      TRAILER_TIRE_BLOWOUT_SET_VERSION: "9"
      DEFAULT_CONSTANT_WIND_SET_VERSION: "5"
      POSE_DELAY_TEST_DRIVE_REPORT_NAME: "Pose Delay - Control Structured Test"
      DEFAULT_SIDE_WIND_GUSTS_SET_VERSION: "11"
      CONSTANT_WIND_TEST_DRIVE_REPORT_NAME: "Constant Wind Speed and Direction - Control Structured Test"
      NON_UNIFORM_ROAD_GEOMETRY_SET_VERSION: "3"
      DEFAULT_UNIFORM_ROAD_GRADE_SET_VERSION: "10"
      SIDE_WIND_GUSTS_TEST_DRIVE_REPORT_NAME: "Side Wind Gusts - Control Structured Test"
      DEFAULT_TRACTOR_TIRE_BLOWOUT_SET_VERSION: "4"
      DEFAULT_TRAILER_TIRE_BLOWOUT_SET_VERSION: "9"
      TRAILER_LOAD_COG_DISPLACEMENT_SET_VERSION: "8"
      UNIFORM_ROAD_GRADE_TEST_DRIVE_REPORT_NAME: "Road Geometry - Uniform Road Grade - Control Structured Test"
      TRACTOR_TIRE_BLOWOUT_TEST_DRIVE_REPORT_NAME: "Tractor Tire Blowout - Control Structured Test"
      TRAILER_TIRE_BLOWOUT_TEST_DRIVE_REPORT_NAME: "Trailer Tire Blowout - Control Structured Test"
      DEFAULT_NON_UNIFORM_ROAD_GEOMETRY_SET_VERSION: "3"
      NON_UNIFORM_ROAD_GEOMETRY_TEST_DRIVE_REPORT_NAME: "Road Geometry - Non-Uniform - Control Structured Test"
      DEFAULT_TRAILER_LOAD_COG_DISPLACEMENT_SET_VERSION: "8"
      TRAILER_LOAD_COG_DISPLACEMENT_TEST_DRIVE_REPORT_NAME: "Trailer Load COG Variation - Control Structured Test"
      CONSTANT_WIND_SET_VERSION: "${CONSTANT_WIND_SET_VERSION:-$$DEFAULT_CONSTANT_WIND_SET_VERSION}"
    command: echo "hello world ${BUILDKITE_PULL_REQUEST_BASE_BRANCH}"

EOF

