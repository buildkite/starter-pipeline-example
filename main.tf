terraform {
  required_providers {
    buildkite = {
      source  = "buildkite/buildkite"
      version = "~> 0.16.2"
    }
  }
}

provider "buildkite" {
  api_token    = var.buildkite_api_token
}


data "buildkite_pipeline" "pipeline" {
  slug         = "child-pipeline"
   
}

data "buildkite_team" "team" {
  slug = "Everyone"
}


# allow everyone in the "Everyone" team read-only access to pipeline
resource "buildkite_pipeline_team" "pipeline_team" {
  pipeline_id  = data.buildkite_pipeline.pipeline.id
  team_id      = data.buildkite_team.team.id
  access_level = "READ_ONLY"
}
