<!-- BEGIN_TF_DOCS -->
# terraform-aviatrix-megaport-edge-spoke

### Description
This module deploys the Aviatrix Edge Gateway in a Megaport location. It can take between 15 and 60 minutes after the deployment has completed, before you will see the gateway be in the "Up" state in the controller.

### Compatibility
Module | Terraform | Controller | Aviatrix Terraform provider | Megaport  Terraform provider
:--- | :--- | :--- | :--- | :---
v1.1.1 | >=1.3 | 7.2 | ~> 3.2.0 | >= 1.2.1

### Usage Example
```hcl
module "edge" {
  source  = "terraform-aviatrix-modules/megaport-edge-spoke/aviatrix"
  version = "v1.1.1"

  name              = "megaport1"
  account           = "megaport_account"
  site_id           = "dc1"
  local_as_number   = 65000
  lan_ip            = "10.10.10.10/24"
  wan1_ip           = "10.10.11.1/24"
  wan1_gateway_ip   = "10.10.11.254"
  megaport_location = "Digital Realty Chicago ORD11 (CHI2)"
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | Megaport account on the Aviatrix controller. | `string` | n/a | yes |
| <a name="input_approved_learned_cidrs"></a> [approved\_learned\_cidrs](#input\_approved\_learned\_cidrs) | Set of approved learned CIDRs. Valid only when enable\_learned\_cidrs\_approval is set to true. Example: ["10.1.0.0/16", "10.2.0.0/16"]. | `list(string)` | `null` | no |
| <a name="input_contract_term_months"></a> [contract\_term\_months](#input\_contract\_term\_months) | (Number) The term of the contract in months: valid values are 1, 12, 24, and 36. | `number` | `12` | no |
| <a name="input_cost_centre"></a> [cost\_centre](#input\_cost\_centre) | The cost centre of the MVE. | `string` | `null` | no |
| <a name="input_diversity_zone"></a> [diversity\_zone](#input\_diversity\_zone) | The diversity zone of the MVE. | `string` | `null` | no |
| <a name="input_enable_learned_cidrs_approval"></a> [enable\_learned\_cidrs\_approval](#input\_enable\_learned\_cidrs\_approval) | Switch to enable learned CIDR approval. | `bool` | `null` | no |
| <a name="input_ha_gw"></a> [ha\_gw](#input\_ha\_gw) | Enables creation of a second Megaport gateway. | `bool` | `false` | no |
| <a name="input_ha_lan_ip"></a> [ha\_lan\_ip](#input\_ha\_lan\_ip) | LAN Interface static IP address. Example: "192.168.1.1/24". | `string` | `""` | no |
| <a name="input_ha_wan1_gateway_ip"></a> [ha\_wan1\_gateway\_ip](#input\_ha\_wan1\_gateway\_ip) | WAN 1 Interface gateway IP. Example: "192.168.2.254". | `string` | `""` | no |
| <a name="input_ha_wan1_ip"></a> [ha\_wan1\_ip](#input\_ha\_wan1\_ip) | WAN 1 Interface static IP address. Example: "192.168.2.1/24". | `string` | `""` | no |
| <a name="input_ha_wan1_public_ip"></a> [ha\_wan1\_public\_ip](#input\_ha\_wan1\_public\_ip) | WAN 1 public IP. | `string` | `""` | no |
| <a name="input_ha_wan2_gateway_ip"></a> [ha\_wan2\_gateway\_ip](#input\_ha\_wan2\_gateway\_ip) | WAN 2 Interface gateway IP. Example: "192.168.2.254". | `string` | `""` | no |
| <a name="input_ha_wan2_ip"></a> [ha\_wan2\_ip](#input\_ha\_wan2\_ip) | WAN 2 Interface static IP address. Example: "192.168.2.1/24". | `string` | `""` | no |
| <a name="input_ha_wan3_gateway_ip"></a> [ha\_wan3\_gateway\_ip](#input\_ha\_wan3\_gateway\_ip) | WAN 3 Interface gateway IP. Example: "192.168.2.254". | `string` | `""` | no |
| <a name="input_ha_wan3_ip"></a> [ha\_wan3\_ip](#input\_ha\_wan3\_ip) | WAN 3 Interface static IP address. Example: "192.168.2.1/24". | `string` | `""` | no |
| <a name="input_hagw_diversity_zone"></a> [hagw\_diversity\_zone](#input\_hagw\_diversity\_zone) | The diversity zone of the MVE. | `string` | `null` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The image ID of the MVE. Indicates the software version. | `number` | `85` | no |
| <a name="input_interface_count"></a> [interface\_count](#input\_interface\_count) | The amount of interfaces to provision the Edge gateway with. | `number` | `3` | no |
| <a name="input_lan_ip"></a> [lan\_ip](#input\_lan\_ip) | LAN Interface static IP address. Example: "192.168.1.1/24". | `string` | n/a | yes |
| <a name="input_local_as_number"></a> [local\_as\_number](#input\_local\_as\_number) | BGP AS Number to assign to Edge VM. | `number` | `null` | no |
| <a name="input_megaport_location"></a> [megaport\_location](#input\_megaport\_location) | The name of the Megaport location. Exmaple: "Digital Realty Chicago ORD11 (CHI2)". | `string` | n/a | yes |
| <a name="input_megaport_location_mgmt_internet"></a> [megaport\_location\_mgmt\_internet](#input\_megaport\_location\_mgmt\_internet) | Overwrite the location for the management internet breakout. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Megaport Gateway. | `string` | n/a | yes |
| <a name="input_prepend_as_path"></a> [prepend\_as\_path](#input\_prepend\_as\_path) | List of AS numbers to prepend gateway BGP AS\_Path field. Valid only when local\_as\_number is set. Example: ["65023", "65023"]. | `list(number)` | `null` | no |
| <a name="input_product_size"></a> [product\_size](#input\_product\_size) | The product size for the vendor config. The size defines the MVE specifications including number of cores, bandwidth, and number of connections. | `string` | `"SMALL"` | no |
| <a name="input_site_id"></a> [site\_id](#input\_site\_id) | Site ID for the gateway(s). | `string` | n/a | yes |
| <a name="input_wan1_gateway_ip"></a> [wan1\_gateway\_ip](#input\_wan1\_gateway\_ip) | WAN 1 Interface gateway IP. Example: "192.168.2.254". | `string` | n/a | yes |
| <a name="input_wan1_ip"></a> [wan1\_ip](#input\_wan1\_ip) | WAN 1 Interface static IP address. Example: "192.168.2.1/24". | `string` | n/a | yes |
| <a name="input_wan1_public_ip"></a> [wan1\_public\_ip](#input\_wan1\_public\_ip) | WAN 1 public IP. | `string` | `null` | no |
| <a name="input_wan2_gateway_ip"></a> [wan2\_gateway\_ip](#input\_wan2\_gateway\_ip) | WAN 2 Interface gateway IP. Example: "192.168.2.254". | `string` | `""` | no |
| <a name="input_wan2_ip"></a> [wan2\_ip](#input\_wan2\_ip) | WAN 2 Interface static IP address. Example: "192.168.2.1/24". | `string` | `""` | no |
| <a name="input_wan3_gateway_ip"></a> [wan3\_gateway\_ip](#input\_wan3\_gateway\_ip) | WAN 3 Interface gateway IP. Example: "192.168.2.254". | `string` | `""` | no |
| <a name="input_wan3_ip"></a> [wan3\_ip](#input\_wan3\_ip) | WAN 3 Interface static IP address. Example: "192.168.2.1/24". | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aviatrix_edge_equinix"></a> [aviatrix\_edge\_equinix](#output\_aviatrix\_edge\_equinix) | n/a |
| <a name="output_aviatrix_edge_equinix_ha"></a> [aviatrix\_edge\_equinix\_ha](#output\_aviatrix\_edge\_equinix\_ha) | n/a |
| <a name="output_ha_management_ip"></a> [ha\_management\_ip](#output\_ha\_management\_ip) | n/a |
| <a name="output_ha_mve"></a> [ha\_mve](#output\_ha\_mve) | n/a |
| <a name="output_management_ip"></a> [management\_ip](#output\_management\_ip) | n/a |
| <a name="output_mve"></a> [mve](#output\_mve) | n/a |
<!-- END_TF_DOCS -->