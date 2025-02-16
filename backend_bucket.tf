# backend_bucket.tf
resource "google_storage_bucket" "terraform_state" {
  name          = "my-terraform-state-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 # Automatically delete objects older than 30 days
    }
  }

  versioning {
    enabled = true
  }

  logging {
    log_bucket = "my-terraform-state-bucket-logs"
  }

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
