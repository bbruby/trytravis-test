/* resource "google_storage_bucket" "state_storage" {
  name = "storage-bucket-eugenebbr-prd"
  lifecycle {
    prevent_destroy = false
  }
  versioning {
    enabled = true
  }
} */

terraform {
  backend "gcs" {
    bucket = "storage-bucket-eugenebbr-prd"
    prefix = "terraform/state"
  }
}
