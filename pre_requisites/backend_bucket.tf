resource "google_storage_bucket" "prerequisites_state_bucket" {
  name          = "gcp-prerequisites-state-bucket"
  location      = "US"
  force_destroy = false # Disable automatic deletion of the bucket

  versioning {
    enabled = true # Enable versioning to retain historical versions
  }

  labels = {
    environment = "production"
    purpose     = "prerequisites-state-storage"
    owner       = "terraform"
  }

  logging {
    log_bucket = "gcp-prerequisites-state-logs"
  }
}
