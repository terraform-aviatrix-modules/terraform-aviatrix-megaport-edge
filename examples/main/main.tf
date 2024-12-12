module "edge" {
  source  = "terraform-aviatrix-modules/megaport-edge-spoke/aviatrix"
  version = "v1.0.1"

  name              = "megaport1"
  account           = "megaport_account"
  site_id           = "dc1"
  local_as_number   = 65000
  lan_ip            = "10.10.10.10/24"
  wan1_ip           = "10.10.11.1/24"
  wan1_gateway_ip   = "10.10.11.254"
  megaport_location = "Digital Realty Chicago ORD11 (CHI2)"
}
