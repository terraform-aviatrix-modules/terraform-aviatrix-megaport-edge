locals {
  #Grab cloud init from file and decode it
  original_cloud_init = yamldecode(data.local_file.cloud_init_content.content)

  #take write_files content section from original cloud init and decode it
  write_files_orig = jsondecode(local.original_cloud_init.write_files[0].content)

  management_prefix      = megaport_vxc.mgmt_internet.csp_connections[0].customer_ip4_address
  hagw_management_prefix = var.ha_gw ? megaport_vxc.hagw_mgmt_internet[0].csp_connections[0].customer_ip4_address : null

  controller_ip = local.write_files_orig.controller_ip

  additional_wan_interfaces = {
    for wan, wan_config in {
      eth3 = { ip = var.wan2_ip, gateway = var.wan2_gateway_ip }
      eth4 = { ip = var.wan3_ip, gateway = var.wan3_gateway_ip }
    } : wan => wan_config if wan_config.ip != ""
  }

  ha_additional_wan_interfaces = {
    for wan, wan_config in {
      eth3 = { ip = var.ha_wan2_ip, gateway = var.ha_wan2_gateway_ip }
      eth4 = { ip = var.ha_wan3_ip, gateway = var.ha_wan3_gateway_ip }
    } : wan => wan_config if wan_config.ip != ""
  }
}
