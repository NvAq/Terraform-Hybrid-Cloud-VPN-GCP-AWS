# modules/gcp_vpn/variables.tf
variable "gcp_region" {
  type        = string
  description = "The GCP region where the VPN gateway will be deployed."
}

variable "gcp_network_name" {
  type        = string
  description = "The name of the GCP network to attach the VPN gateway to."
}

variable "local_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for the local GCP network."
}

variable "remote_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for the remote AWS network."
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
