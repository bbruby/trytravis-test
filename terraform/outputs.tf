output "app_external_ip" {
  value = google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip
}

output "app2_external_ip" {
  value = google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip
}

output "http_load_balancer_external_ip" {
  value = google_compute_global_forwarding_rule.app-fwrd-rule.ip_address
}
