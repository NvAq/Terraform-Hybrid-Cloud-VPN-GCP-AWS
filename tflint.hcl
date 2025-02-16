# tflint.hcl
config {
  module = true
  force  = false

  # Enable all rules by default
  enabled_rules = ["all"]

  # Exclude specific directories if needed
  exclude_directories = ["modules/**/tests"]
}

plugin "google" {
  enabled = true
  version = "0.23.0" # Use the latest version of the Google plugin
  source  = "github.com/terraform-linters/tflint-ruleset-google"
}

plugin "aws" {
  enabled = true
  version = "0.21.0" # Use the latest version of the AWS plugin
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "google_compute_instance_invalid_machine_type" {
  enabled = true
}

rule "aws_instance_invalid_type" {
  enabled = true
}
