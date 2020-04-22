terraform {
  required_version = "~> 0.12.0"
}

provider "google" {
  version = "~> 2.5.0"
  project = var.project
  region  = var.region
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  zone            = var.zone
  app_disk_image  = var.app_disk_image
  db_ip           = module.db.db_ip
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
}

module "vpc" {
  source = "../modules/vpc"
  # source_ranges = ["78.144.22.36/32"]
  source_ranges = ["0.0.0.0/0"]
}
