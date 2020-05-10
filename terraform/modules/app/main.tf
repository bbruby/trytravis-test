resource "google_compute_instance" "app" {
  name         = "reddit-app-${var.env}"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["reddit-app"]
  labels = {
    environment = var.env_label
  }
  boot_disk {
    initialize_params { image = var.app_disk_image }
  }
  network_interface {
    network = var.env_network
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  # connection {
  #   type        = "ssh"
  #   host        = self.network_interface[0].access_config[0].nat_ip
  #   user        = "appuser"
  #   agent       = false
  #   private_key = file(var.private_key_path)
  # }

  # provisioner "file" {
  #   content      = templatefile("${path.module}/files/puma.service.tpl", { db_ip = var.db_ip })
  #   destination = "/tmp/puma.service"
  # }

  # provisioner "remote-exec" {
  #   script = "${path.module}/files/deploy.sh"
  # }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip-${var.env}"
}
