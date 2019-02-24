# This file is custom to the train-habitat project

resource "github_issue_label" "component_ssh_connections" {
  repository  = "${var.repo_name}"
  name        = "Component/SSH Connection"
  color       = "48bdb9" # aqua
  description = "When a connection is made over SSH"
}

resource "github_issue_label" "component_api_connections" {
  repository  = "${var.repo_name}"
  name        = "Component/HTTP Connection"
  color       = "48bdb9" # aqua
  description = "When a connection is made over the HTTP API"
}

resource "github_issue_label" "component_cli_queries" {
  repository  = "${var.repo_name}"
  name        = "Component/CLI Queries"
  color       = "48bdb9" # aqua
  description = "When query is made via the CLI"
}
