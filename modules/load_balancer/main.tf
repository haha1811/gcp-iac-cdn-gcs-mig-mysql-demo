resource "google_compute_backend_service" "default" {
  name                  = "app-backend"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 10
  enable_cdn            = true

  backend {
    group = var.mig_group
  }

    health_checks = [google_compute_health_check.default.self_link]

}

resource "google_compute_url_map" "default" {
  name            = "lb-url-map"

  default_url_redirect {
    https_redirect = false
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query = false
  }
}

resource "google_compute_target_http_proxy" "default" {
  name   = "http-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "http-lb"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.default.self_link
}

resource "google_compute_health_check" "default" {
  name = "mig-health-check"

  http_health_check {
    request_path = "/"
    port         = 80
  }

  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
}


output "ip" {
  value = google_compute_global_forwarding_rule.default.ip_address
}