# values.tf
gcp_region = "us-central1"
aws_region = "us-west-2"
num_tunnels = 2

local_cidr_blocks = ["192.168.1.0/24"]
remote_cidr_blocks = ["10.0.0.0/16"]

ike_phase1_proposals = [
  {
    authentication = "SHA2-256"
    encryption     = "AES-256-GCM"
    dh_group       = "14 (2048 bit)"
  },
]

pre_shared_key = "secure-pre-shared-key"
gcp_network_name = "hybrid-vpn-network"
aws_vpc_id = "vpc-12345678"
