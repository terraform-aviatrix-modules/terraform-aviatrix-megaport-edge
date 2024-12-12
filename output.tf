output "management_ip" {
  value = local.management_prefix
}

output "ha_management_ip" {
  value = local.hagw_management_prefix
}

output "mve" {
  value = megaport_mve.default
}

output "ha_mve" {
  value = var.ha_gw ? megaport_mve.ha_gw : null
}
