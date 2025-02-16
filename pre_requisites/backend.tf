terraform {
  backend "gcs" {
    bucket = "gcp-prerequisites-state-bucket"
    prefix = "prerequisites/state"
  }
}
