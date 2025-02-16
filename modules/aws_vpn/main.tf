resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = var.gcp_vpn_gateway_ip
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "main" {
  for_each = toset(local.tunnel_names)

  customer_gateway_id = aws_customer_gateway.main.id
  vpn_gateway_id      = var.aws_vpn_gateway_id
  static_routes_only = true

  tunnel1_preshared_key = var.pre_shared_key
  tunnel2_preshared_key = var.pre_shared_key
}
