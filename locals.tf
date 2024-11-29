locals {
  #Grab cloud init from file and decode it
  original_cloud_init = yamldecode(data.local_file.cloud_init_content.content)

  #take write_files content section from original cloud init and decode it
  write_files_orig = jsondecode(local.original_cloud_init.write_files[0].content)

  #Select interface mapping content
  interface_mapping = lookup(local.interface_mapping_list, var.interface_count, null)
  interface_mapping_list = {
    3 = [{ "type" : "WAN", "type_index" : 0 }, { "type" : "LAN", "type_index" : 0 }, { "type" : "MGMT", "type_index" : 0 }]
    4 = [{ "type" : "WAN", "type_index" : 0 }, { "type" : "LAN", "type_index" : 0 }, { "type" : "MGMT", "type_index" : 0 }, { "type" : "WAN", "type_index" : 1 }]
    5 = [{ "type" : "WAN", "type_index" : 0 }, { "type" : "LAN", "type_index" : 0 }, { "type" : "MGMT", "type_index" : 0 }, { "type" : "WAN", "type_index" : 1 }, { "type" : "WAN", "type_index" : 2 }]
  }

  #Inject interface mapping content into write_files content section
  injected_content = merge(
    local.write_files_orig,
    { interface_mapping = local.interface_mapping }
  )

  #Encode the write_files content section to json
  encoded_injected_content = jsonencode(local.injected_content)

  #Overwrite write files content section in original write files object
  write_files_updated = [
    merge(
      local.original_cloud_init.write_files[0],
      { content = local.encoded_injected_content }
    )
  ]

  #Overwrite write files section in original cloud init data
  updated_cloud_init = merge(
    local.original_cloud_init,
    { write_files = local.write_files_updated }
  )

  #Encode the cloud init data to yaml
  updated_cloud_init_yaml = yamlencode(local.updated_cloud_init)

  #Encode to rendered templatefile to base64.
  base64_encoded_output = base64encode(data.template_file.init.rendered)

  management_prefix = megaport_vxc.mgmt_internet.csp_connections[0].customer_ip4_address

  controller_ip = local.write_files_orig.controller_ip

  additional_wan_interfaces = {
    for wan, wan_config in {
      eth3 = { ip = var.wan2_ip, gateway = var.wan2_gateway_ip }
      eth4 = { ip = var.wan3_ip, gateway = var.wan3_gateway_ip }
    } : wan => wan_config if wan_config.ip != ""
  }
}
