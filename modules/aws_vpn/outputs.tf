# modules/aws_vpn/outputs.tf
output "vpn_connection_ids" {
  value       = [for conn in aws_vpn_connection.main : conn.id]
  description = "The IDs of the AWS VPN connections."
}

output "customer_gateway_id" {
  value       = aws_customer_gateway.main.id
  description = "The ID of the AWS customer gateway."
}
