This deploys a high available pair of Aviatrix Edge as Spoke gateways in Megaport.

```hcl
module "edge" {
  source  = "terraform-aviatrix-modules/megaport-edge-spoke/aviatrix"
  version = "v1.1.1"

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
```