# modules/gcp_vpn/outputs.tf
output "vpn_gateway_ip" {
  value       = google_compute_forwarding_rule.main[0].ip_address
  description = "The external IP address of the GCP VPN gateway."
}

output "tunnel_ids" {
  value       = [for tunnel in google_compute_vpn_tunnel.main : tunnel.id]
  description = "The IDs of the GCP VPN tunnels."
}
