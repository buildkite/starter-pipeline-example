terraform {
  required_providers {
    buildkite = {
      source  = "buildkite/buildkite"
      version = "~> 0.13"
    }
  }
}

data "buildkite_pipeline" "child-pipeline" {
  slug         = "child-pipeline"
  organization = var.buildkite_org
}



resource "buildkite_team" "team" {
  name                = "Everyone"
  privacy             = "VISIBLE"
  default_team        = false
  default_member_role = "MEMBER"
}

# allow everyone in the "Everyone" team read-only access to pipeline
resource "buildkite_pipeline_team" "pipeline_team" {
  pipeline_id  = data.buildkite_pipeline.child-pipeline.id
  team_id      = buildkite_team.team.id
  access_level = "READ_ONLY"
}
