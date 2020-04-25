/*resource "google_storage_bucket" "state_storage" {
  name = "storage-bucket-eugenebbr-stg"
  lifecycle {
    prevent_destroy = false
  }
  versioning {
    enabled = true
  }
}*/

terraform {
  backend "gcs" {
    bucket = "storage-bucket-eugenebbr-stg"
    prefix = "terraform/state/stg"
  }
}