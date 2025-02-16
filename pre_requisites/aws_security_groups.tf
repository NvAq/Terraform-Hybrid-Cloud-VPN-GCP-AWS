resource "aws_security_group" "allow_gcp_vpn_traffic" {
  name        = "aws-vpn-allow-gcp-traffic"
  description = "Allow traffic from GCP network for HA VPN"
  vpc_id      = var.aws_vpc_id

  ingress {
    from_port   = 500
    to_port     = 500
    protocol    = "udp"
    cidr_blocks = var.local_cidr_blocks # Allow IKE (UDP 500)
  }

  ingress {
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
    cidr_blocks = var.local_cidr_blocks # Allow NAT-T (UDP 4500)
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "esp"
    cidr_blocks = var.local_cidr_blocks # Allow Encapsulating Security Payload (ESP Protocol 50)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Environment = "production"
    Purpose     = "vpn-security-groups"
    Owner       = "terraform"
  }
}

resource "aws_security_group" "allow_icmp_ping" {
  name        = "aws-vpn-allow-icmp-ping"
  description = "Allow ICMP (ping) from GCP network"
  vpc_id      = var.aws_vpc_id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.local_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Environment = "production"
    Purpose     = "testing-connectivity"
    Owner       = "terraform"
  }
}
