terraform {
  backend "gcs" {
    bucket = "gcp-vpn-state-bucket"
    prefix = "main/state"
  }
}
