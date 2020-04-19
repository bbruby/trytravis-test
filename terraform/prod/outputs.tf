/* output "app_external_ip" {
  value = google_compute_instance.app.network_interface.0.access_config.0.nat_ip
}
 */
/* output "db_external_ip" {
  value = google_compute_instance.db.network_interface.0.access_config.0.nat_ip
}

output "http_load_balancer_external_ip" {
  value = google_compute_global_forwarding_rule.app-fwrd-rule.ip_address
} */
output "app_external_ip" {
  value = module.app.app_external_ip
}

output "db_external_ip" {
  value = module.db.db_external_ip
}
