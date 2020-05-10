resource "google_compute_instance" "db" {
  name         = "reddit-db-${var.env}"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["reddit-db"]
   labels = {
    environment = var.env_label
  }
  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }
  network_interface {
    network = var.env_network
    access_config {}
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}
