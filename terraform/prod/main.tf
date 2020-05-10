terraform {
  required_version = "~> 0.12.0"
}

provider "google" {
  version = "~> 2.5.0"
  project = var.project
  region  = var.region
}

module "vpc" {
  source        = "../modules/vpc"
  zone          = var.zone
  source_ranges = ["0.0.0.0/0"]
  env           = var.env
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  zone            = var.zone
  app_disk_image  = var.app_disk_image
  db_ip           = module.db.db_ip
  env             = var.env
  env_network     = module.vpc.env_network
  env_label       = var.env_label
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
  env             = var.env
  env_network     = module.vpc.env_network
  env_label       = var.env_label
}
