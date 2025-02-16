module "gcp_firewall_rules" {
  source = "../modules/gcp_vpn"

  gcp_network_name    = var.gcp_network_name
  local_cidr_blocks   = var.local_cidr_blocks
  remote_cidr_blocks  = var.remote_cidr_blocks
}

module "aws_security_groups" {
  source = "../modules/aws_vpn"

  aws_vpc_id          = var.aws_vpc_id
  local_cidr_blocks   = var.local_cidr_blocks
  remote_cidr_blocks  = var.remote_cidr_blocks
}
