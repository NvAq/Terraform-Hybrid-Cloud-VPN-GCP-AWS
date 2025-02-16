# modules/aws_vpn/variables.tf
variable "aws_region" {
  type        = string
  description = "The AWS region where the VPN connection will be established."
}

variable "aws_vpc_id" {
  type        = string
  description = "The ID of the AWS VPC to connect to."
}

variable "local_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for the local AWS network."
}

variable "remote_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for the remote GCP network."
}

variable "num_tunnels" {
  type        = number
  description = "Number of VPN tunnels to create."
  validation {
    condition     = var.num_tunnels > 0
    error_message = "Number of tunnels must be greater than 0."
  }
}

variable "ike_phase1_proposals" {
  type = list(object({
    authentication = string
    encryption     = string
    dh_group       = string
  }))
  description = "IKE Phase 1 proposals for the VPN tunnels."
}

variable "pre_shared_key" {
  type        = string
  sensitive   = true
  description = "Pre-shared key for the VPN connection."
}
