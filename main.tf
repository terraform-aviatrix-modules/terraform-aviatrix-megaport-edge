resource "aviatrix_edge_equinix" "default" {
  account_name = var.account

  gw_name                = var.name
  site_id                = var.site_id
  ztp_file_download_path = "./"

  interfaces {
    name          = "eth0"
    type          = "WAN"
    ip_address    = var.wan1_ip
    gateway_ip    = var.wan1_gateway_ip
    wan_public_ip = var.wan1_public_ip
  }

  interfaces {
    name       = "eth1"
    type       = "LAN"
    ip_address = var.lan_ip
  }

  dynamic "interfaces" {
    for_each = local.additional_wan_interfaces

    content {
      name       = interfaces.key
      type       = "WAN"
      ip_address = interfaces.value.ip
      gateway_ip = interfaces.value.gateway
    }
  }


  lifecycle {
    ignore_changes = [
      management_egress_ip_prefix_list,
      interfaces
    ]
  }
}

resource "aviatrix_edge_equinix_ha" "default" {
  count                  = var.ha_gw ? 1 : 0
  primary_gw_name        = aviatrix_edge_equinix.default.gw_name
  ztp_file_download_path = "./"

  interfaces {
    name          = "eth0"
    type          = "WAN"
    ip_address    = var.ha_wan1_ip
    gateway_ip    = var.ha_wan1_gateway_ip
    wan_public_ip = var.ha_wan1_public_ip
  }

  interfaces {
    name       = "eth1"
    type       = "LAN"
    ip_address = var.ha_lan_ip
  }

  dynamic "interfaces" {
    for_each = local.ha_additional_wan_interfaces

    content {
      name       = interfaces.key
      type       = "WAN"
      ip_address = interfaces.value.ip
      gateway_ip = interfaces.value.gateway
    }
  }


  lifecycle {
    ignore_changes = [
      management_egress_ip_prefix_list,
      interfaces
    ]
  }
}

data "local_file" "cloud_init_content" {
  filename = format("./%s-%s-cloud-init.txt", aviatrix_edge_equinix.default.id, aviatrix_edge_equinix.default.site_id)

  depends_on = [aviatrix_edge_equinix.default]
}

data "local_file" "hagw_cloud_init_content" {
  count    = var.ha_gw ? 1 : 0
  filename = format("./%s-cloud-init.txt", aviatrix_edge_equinix_ha.default[0].id)

  depends_on = [aviatrix_edge_equinix_ha.default]
}

data "megaport_location" "loc" {
  name = var.megaport_location
}

data "megaport_location" "internet_loc" {
  name = coalesce(var.megaport_location_mgmt_internet, var.megaport_location)
}

data "megaport_partner" "internet" {
  connect_type = "TRANSIT"
  company_name = "Networks"
  product_name = "Megaport Internet"
  location_id  = data.megaport_location.internet_loc.id
}

resource "megaport_vxc" "mgmt_internet" {
  product_name         = "Transit VXC Example"
  rate_limit           = 100
  contract_term_months = 1

  a_end = {
    requested_product_uid = megaport_mve.default.product_uid
    vnic_index            = 2
  }

  b_end = {
    requested_product_uid = data.megaport_partner.internet.product_uid
  }

  b_end_partner_config = {
    partner = "transit"
  }
}

resource "megaport_vxc" "hagw_mgmt_internet" {
  count                = var.ha_gw ? 1 : 0
  product_name         = "Transit VXC Example"
  rate_limit           = 100
  contract_term_months = 1

  a_end = {
    requested_product_uid = megaport_mve.ha_gw[0].product_uid
    vnic_index            = 2
  }

  b_end = {
    requested_product_uid = data.megaport_partner.internet.product_uid
  }

  b_end_partner_config = {
    partner = "transit"
  }
}

resource "megaport_mve" "default" {
  product_name         = "Secure Edge"
  location_id          = data.megaport_location.loc.id
  contract_term_months = 1

  vnics = [
    {
      description = "WAN"
    },
    {
      description = "LAN"
    },
    {
      description = "Management"
    }
  ]

  vendor_config = {
    vendor       = "aviatrix"
    product_size = "SMALL"
    image_id     = 85
    cloud_init   = data.local_file.cloud_init_content.content_base64
  }

  lifecycle {
    ignore_changes = [vendor_config]
  }

  depends_on = [aviatrix_edge_equinix.default]
}

resource "megaport_mve" "ha_gw" {
  count                = var.ha_gw ? 1 : 0
  product_name         = "Secure Edge"
  location_id          = data.megaport_location.loc.id
  contract_term_months = 1

  vnics = [
    {
      description = "WAN"
    },
    {
      description = "LAN"
    },
    {
      description = "Management"
    }
  ]

  vendor_config = {
    vendor       = "aviatrix"
    product_size = "SMALL"
    image_id     = 85
    cloud_init   = data.local_file.hagw_cloud_init_content[0].content_base64
  }

  lifecycle {
    ignore_changes = [vendor_config]
  }

  depends_on = [aviatrix_edge_equinix.default]
}

data "aviatrix_caller_identity" "self" {}

#Set mgmt egress CIDR
resource "terracurl_request" "update_edge_gateway" {
  name            = "update_edge_gateway"
  method          = "POST"
  url             = "https://${local.controller_ip}/v2/api"
  skip_tls_verify = true
  max_retry       = 3
  retry_interval  = 3

  headers = {
    "Content-Type" = "application/json"
  }

  request_body = jsonencode({
    action         = "update_edge_gateway"
    CID            = data.aviatrix_caller_identity.self.cid
    name           = aviatrix_edge_equinix.default.id
    mgmt_egress_ip = local.management_prefix
  })

  response_codes = [200]

  lifecycle {
    ignore_changes = all
  }
}

resource "terracurl_request" "update_ha_edge_gateway" {
  count           = var.ha_gw ? 1 : 0
  name            = "hagw_update_edge_gateway"
  method          = "POST"
  url             = "https://${local.controller_ip}/v2/api"
  skip_tls_verify = true
  max_retry       = 3
  retry_interval  = 3

  headers = {
    "Content-Type" = "application/json"
  }

  request_body = jsonencode({
    action         = "update_edge_gateway"
    CID            = data.aviatrix_caller_identity.self.cid
    name           = aviatrix_edge_equinix_ha.default[0].id
    mgmt_egress_ip = local.hagw_management_prefix
  })

  response_codes = [200]

  lifecycle {
    ignore_changes = all
  }
}
