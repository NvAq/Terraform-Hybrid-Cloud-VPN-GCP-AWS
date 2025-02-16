# outputs.tf
output "gcp_vpn_gateway_ip" {
  value       = module.gcp_vpn.vpn_gateway_ip
  description = "The external IP address of the GCP VPN gateway."
}

output "aws_vpn_connection_ids" {
  value       = module.aws_vpn.vpn_connection_ids
  description = "The IDs of the AWS VPN connections."
}
