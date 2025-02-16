resource "google_compute_vpn_gateway" "main" {
  name    = "gcp-vpn-gateway"
  network = var.gcp_network_name
  region  = var.gcp_region
}

resource "google_compute_forwarding_rule" "main" {
  for_each = toset(local.tunnel_names)

  name       = each.value
  region     = var.gcp_region
  ip_protocol = "ESP"
  target     = google_compute_vpn_gateway.main.self_link
}
