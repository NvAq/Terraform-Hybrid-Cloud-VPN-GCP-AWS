# main.tf
module "gcp_vpn" {
  source = "./modules/gcp_vpn"

  gcp_region          = var.gcp_region
  gcp_network_name    = var.gcp_network_name
  local_cidr_blocks   = var.local_cidr_blocks
  remote_cidr_blocks  = var.remote_cidr_blocks
  num_tunnels         = var.num_tunnels
  ike_phase1_proposals = var.ike_phase1_proposals
  pre_shared_key      = var.pre_shared_key
}

module "aws_vpn" {
  source = "./modules/aws_vpn"

  aws_region          = var.aws_region
  aws_vpc_id          = var.aws_vpc_id
  local_cidr_blocks   = var.remote_cidr_blocks
  remote_cidr_blocks  = var.local_cidr_blocks
  num_tunnels         = var.num_tunnels
  ike_phase1_proposals = var.ike_phase1_proposals
  pre_shared_key      = var.pre_shared_key
}
