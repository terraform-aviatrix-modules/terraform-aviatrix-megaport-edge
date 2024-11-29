resource "aviatrix_edge_gateway_selfmanaged" "default" {
  gw_name                = var.name
  site_id                = var.site_id
  ztp_file_type          = "cloud-init"
  ztp_file_download_path = "./"

  local_as_number = var.local_as_number
  prepend_as_path = var.prepend_as_path

  interfaces {
    name       = "eth0"
    type       = "WAN"
    ip_address = var.wan1_ip
    gateway_ip = var.wan1_gateway_ip
    #wan_public_ip = "64.71.24.221"
  }

  interfaces {
    name       = "eth1"
    type       = "LAN"
    ip_address = var.lan_ip
  }

  interfaces {
    name        = "eth2"
    type        = "MANAGEMENT"
    enable_dhcp = true
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
    ]
  }
}

data "local_file" "cloud_init_content" {
  filename = format("./%s-%s-cloud-init.txt", aviatrix_edge_gateway_selfmanaged.default.gw_name, aviatrix_edge_gateway_selfmanaged.default.site_id)

  depends_on = [aviatrix_edge_gateway_selfmanaged.default]
}

data "template_file" "init" {
  template = file("${path.module}/cloud-init.tpl")
  vars = {
    YAML = local.updated_cloud_init_yaml
  }
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
    cloud_init   = local.base64_encoded_output
  }

  lifecycle {
    ignore_changes = [vendor_config]
  }

  depends_on = [aviatrix_edge_gateway_selfmanaged.default]
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
    name           = aviatrix_edge_gateway_selfmanaged.default.gw_name
    mgmt_egress_ip = local.management_prefix
  })

  response_codes = [200]

  lifecycle {
    ignore_changes = all
  }
}
