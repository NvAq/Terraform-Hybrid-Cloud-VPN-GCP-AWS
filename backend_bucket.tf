resource "google_storage_bucket" "main_state_bucket" {
  name          = "gcp-vpn-state-bucket"
  location      = "US"
  force_destroy = false # Disable automatic deletion of the bucket

  versioning {
    enabled = true # Enable versioning to retain historical versions
  }

  labels = {
    environment = "production"
    purpose     = "vpn-state-storage"
    owner       = "terraform"
  }

  logging {
    log_bucket = "gcp-vpn-state-logs"
  }
}
