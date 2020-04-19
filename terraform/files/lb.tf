resource "google_compute_instance_group" "app-srv-grp" {
  name        = "app-srv-grp"
  description = "App instance group"

  instances = google_compute_instance.app.*.self_link

  named_port {
    name = "http"
    port = "9292"
  }

  zone = var.zone
}

resource "google_compute_http_health_check" "app-hlth-chk" {
  name         = "app-hlth-chk"
  request_path = "/"
  port         = 9292
}

resource "google_compute_backend_service" "app-srv-bes" {
  name        = "app-srv-bes"
  description = "Backend service for app"
  port_name   = "http"
  protocol    = "HTTP"

  backend {
    group = google_compute_instance_group.app-srv-grp.self_link
  }

  health_checks = [google_compute_http_health_check.app-hlth-chk.self_link]
}

resource "google_compute_global_forwarding_rule" "app-fwrd-rule" {
  name        = "app-fwrd-rule"
  description = "Forwarding rule"
  target      = google_compute_target_http_proxy.lb-http-proxy.self_link
  port_range  = "80"
}

resource "google_compute_target_http_proxy" "lb-http-proxy" {
  name        = "lb-http-proxy"
  description = "Target HTTP proxy"
  url_map     = google_compute_url_map.app-urlmap.self_link
}

resource "google_compute_url_map" "app-urlmap" {
  name            = "app-urlmap"
  description     = "URL map for route requests to a backend service"
  default_service = google_compute_backend_service.app-srv-bes.self_link
}
