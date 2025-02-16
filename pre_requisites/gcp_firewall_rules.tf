resource "google_compute_firewall" "allow_aws_vpn_traffic" {
  name    = "gcp-vpn-allow-aws-traffic"
  network = var.gcp_network_name

  allow {
    protocol = "udp"
    ports    = ["500", "4500"] # Allow IKE (UDP 500) and NAT-T (UDP 4500)
  }

  allow {
    protocol = "esp" # Allow Encapsulating Security Payload (ESP Protocol 50)
  }

  source_ranges = var.remote_cidr_blocks

  labels = {
    environment = "production"
    purpose     = "vpn-firewall-rules"
    owner       = "terraform"
  }
}

resource "google_compute_firewall" "allow_icmp_ping" {
  name    = "gcp-vpn-allow-icmp-ping"
  network = var.gcp_network_name

  allow {
    protocol = "icmp"
  }

  source_ranges = var.remote_cidr_blocks

  labels = {
    environment = "production"
    purpose     = "testing-connectivity"
    owner       = "terraform"
  }
}
