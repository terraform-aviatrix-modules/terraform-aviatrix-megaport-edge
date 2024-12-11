module "edge" {
  source  = "terraform-aviatrix-modules/megaport-edge/aviatrix"
  version = "v1.1.0"

  name              = "megatest1"
  account           = "megaport_account"
  site_id           = "dc1"
  local_as_number   = 65000
  megaport_location = "Digital Realty Chicago ORD11 (CHI2)"

  #Primary Gateway
  lan_ip          = "10.10.10.10/24"
  wan1_ip         = "10.10.11.10/24"
  wan1_gateway_ip = "10.10.11.254"

  #Secondary Gateway
  ha_gw              = true
  ha_lan_ip          = "10.10.10.11/24"
  ha_wan1_ip         = "10.10.11.11/24"
  ha_wan1_gateway_ip = "10.10.11.254"
}
