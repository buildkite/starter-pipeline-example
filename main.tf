terraform {
  required_providers {
    buildkite = {
      source  = "buildkite/buildkite"
      version = "~> 0.13"
    }
  }
}

provider "buildkite" {
  api_token    = var.buildkite_api_token
  organization = var.buildkite_org
}


resource "buildkite_pipeline" "pipeline" {
  name       = "child-pipeline"
  repository = "https://github.com/PriyaSudip/starter.git"
}

resource "buildkite_team" "team" {
  name                = "Everyone"
  privacy             = "VISIBLE"
  default_team        = false
  default_member_role = "MEMBER"
}

# allow everyone in the "Everyone" team read-only access to pipeline
resource "buildkite_pipeline_team" "pipeline_team" {
  pipeline_id  = buildkite_pipeline.pipeline.id
  team_id      = buildkite_team.team.id
  access_level = "READ_ONLY"
}
