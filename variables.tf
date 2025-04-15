variable "buildkite_api_token" {
  type        = string
  description = "Buildkite API token"
  sensitive   = true
}

variable "buildkite_org" {
  type        = string
  description = "Buildkite organization slug"
}