<!-- BEGIN_TF_DOCS -->
# terraform-aviatrix-megaport-edge

### Description
This module deploys the Aviatrix Edge Gateway in a Megaport location. It can take between 15 and 60 minutes after the deployment has completed, before you will see the gateway be in the "Up" state in the controller.

### Compatibility
Module version | Terraform version
:--- | :---
v1.0.0 | >=1.0 | 7.1 | >= 3.1.0

### Usage Example
```hcl
module "edge" {
  source  = "terraform-aviatrix-modules/megaport-edge/aviatrix"
  version = "v1.0.0"

  name              = "megaport1"
  account           = "megaport_account"
  site_id           = "dc1"
  local_as_number   = 65000
  lan_ip            = "10.10.10.10/24"
  megaport_location = "Digital Realty Chicago ORD11 (CHI2)"
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | Megaport account on the Aviatrix controller. | `string` | n/a | yes |
| <a name="input_interface_count"></a> [interface\_count](#input\_interface\_count) | The amount of interfaces to provision the Edge gateway with. | `number` | `3` | no |
| <a name="input_lan_ip"></a> [lan\_ip](#input\_lan\_ip) | LAN Interface static IP address. Example: "192.168.1.1/24". | `string` | n/a | yes |
| <a name="input_local_as_number"></a> [local\_as\_number](#input\_local\_as\_number) | BGP AS Number to assign to Edge VM. | `number` | n/a | yes |
| <a name="input_megaport_location"></a> [megaport\_location](#input\_megaport\_location) | The name of the Megaport location. Exmaple: "Digital Realty Chicago ORD11 (CHI2)". | `string` | n/a | yes |
| <a name="input_megaport_location_mgmt_internet"></a> [megaport\_location\_mgmt\_internet](#input\_megaport\_location\_mgmt\_internet) | Overwrite the location for the management internet breakout. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Megaport Gateway. | `string` | n/a | yes |
| <a name="input_prepend_as_path"></a> [prepend\_as\_path](#input\_prepend\_as\_path) | List of AS numbers to prepend gateway BGP AS\_Path field. Valid only when local\_as\_number is set. Example: ["65023", "65023"]. | `list(number)` | `null` | no |
| <a name="input_site_id"></a> [site\_id](#input\_site\_id) | Site ID for the gateway(s). | `string` | n/a | yes |
| <a name="input_wan1_gateway_ip"></a> [wan1\_gateway\_ip](#input\_wan1\_gateway\_ip) | WAN 1 Interface gateway IP. Example: "192.168.2.254". | `string` | n/a | yes |
| <a name="input_wan1_ip"></a> [wan1\_ip](#input\_wan1\_ip) | WAN 1 Interface static IP address. Example: "192.168.2.1/24". | `string` | n/a | yes |
| <a name="input_wan2_gateway_ip"></a> [wan2\_gateway\_ip](#input\_wan2\_gateway\_ip) | WAN 2 Interface gateway IP. Example: "192.168.2.254". | `string` | `null` | no |
| <a name="input_wan2_ip"></a> [wan2\_ip](#input\_wan2\_ip) | WAN 2 Interface static IP address. Example: "192.168.2.1/24". | `string` | `""` | no |
| <a name="input_wan3_gateway_ip"></a> [wan3\_gateway\_ip](#input\_wan3\_gateway\_ip) | WAN 3 Interface gateway IP. Example: "192.168.2.254". | `string` | `null` | no |
| <a name="input_wan3_ip"></a> [wan3\_ip](#input\_wan3\_ip) | WAN 3 Interface static IP address. Example: "192.168.2.1/24". | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_management_ip"></a> [management\_ip](#output\_management\_ip) | n/a |
<!-- END_TF_DOCS -->