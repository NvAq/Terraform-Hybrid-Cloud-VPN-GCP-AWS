# locals.tf
locals {
  tunnel_names = [for i in range(var.num_tunnels) : "vpn-tunnel-${i+1}"]
}
