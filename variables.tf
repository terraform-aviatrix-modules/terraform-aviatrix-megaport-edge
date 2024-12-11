variable "name" {
  description = "Name for the Megaport Gateway."
  type        = string
}

variable "account" {
  description = "Megaport account on the Aviatrix controller."
  type        = string
}

variable "site_id" {
  description = "Site ID for the gateway(s)."
  type        = string
}

variable "prepend_as_path" {
  description = "List of AS numbers to prepend gateway BGP AS_Path field. Valid only when local_as_number is set. Example: [\"65023\", \"65023\"]."
  type        = list(number)
  default     = null
}

variable "local_as_number" {
  description = "BGP AS Number to assign to Edge VM."
  type        = number
  default     = null
}

variable "enable_learned_cidrs_approval" {
  description = "Switch to enable learned CIDR approval."
  type        = bool
  default     = null
}

variable "approved_learned_cidrs" {
  description = "Set of approved learned CIDRs. Valid only when enable_learned_cidrs_approval is set to true. Example: [\"10.1.0.0/16\", \"10.2.0.0/16\"]."
  type        = list(string)
  default     = null
}

variable "lan_ip" {
  description = "LAN Interface static IP address. Example: \"192.168.1.1/24\"."
  type        = string
}

variable "wan1_ip" {
  description = "WAN 1 Interface static IP address. Example: \"192.168.2.1/24\"."
  type        = string
}

variable "wan1_gateway_ip" {
  description = "WAN 1 Interface gateway IP. Example: \"192.168.2.254\"."
  type        = string
}

variable "wan1_public_ip" {
  description = "WAN 1 public IP."
  type        = string
  default     = null
}

variable "wan2_ip" {
  description = "WAN 2 Interface static IP address. Example: \"192.168.2.1/24\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "wan2_gateway_ip" {
  description = "WAN 2 Interface gateway IP. Example: \"192.168.2.254\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "wan3_ip" {
  description = "WAN 3 Interface static IP address. Example: \"192.168.2.1/24\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "wan3_gateway_ip" {
  description = "WAN 3 Interface gateway IP. Example: \"192.168.2.254\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "ha_lan_ip" {
  description = "LAN Interface static IP address. Example: \"192.168.1.1/24\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "ha_wan1_ip" {
  description = "WAN 1 Interface static IP address. Example: \"192.168.2.1/24\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "ha_wan1_gateway_ip" {
  description = "WAN 1 Interface gateway IP. Example: \"192.168.2.254\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "ha_wan1_public_ip" {
  description = "WAN 1 public IP."
  type        = string
  default     = ""
  nullable    = false
}

variable "ha_wan2_ip" {
  description = "WAN 2 Interface static IP address. Example: \"192.168.2.1/24\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "ha_wan2_gateway_ip" {
  description = "WAN 2 Interface gateway IP. Example: \"192.168.2.254\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "ha_wan3_ip" {
  description = "WAN 3 Interface static IP address. Example: \"192.168.2.1/24\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "ha_wan3_gateway_ip" {
  description = "WAN 3 Interface gateway IP. Example: \"192.168.2.254\"."
  type        = string
  default     = ""
  nullable    = false
}

variable "megaport_location" {
  description = "The name of the Megaport location. Exmaple: \"Digital Realty Chicago ORD11 (CHI2)\"."
  type        = string
}

variable "interface_count" {
  description = "The amount of interfaces to provision the Edge gateway with."
  type        = number
  default     = 3
  nullable    = false

  validation {
    condition     = var.interface_count >= 3 && var.interface_count <= 5
    error_message = "The value of interface_count must be at least 3 (default) and at most 5."
  }
}

variable "megaport_location_mgmt_internet" {
  description = "Overwrite the location for the management internet breakout."
  default     = ""
  type        = string
  nullable    = false
}

variable "ha_gw" {
  description = "Enables creation of a second Megaport gateway."
  default     = false
  type        = bool
  nullable    = false
}

variable "contract_term_months" {
  description = " (Number) The term of the contract in months: valid values are 1, 12, 24, and 36."
  default     = 12
  type        = number
  nullable    = false
}

variable "image_id" {
  description = "The image ID of the MVE. Indicates the software version."
  default     = 85
  type        = number
  nullable    = false
}

variable "product_size" {
  description = "The product size for the vendor config. The size defines the MVE specifications including number of cores, bandwidth, and number of connections."
  default     = "SMALL"
  type        = string
  nullable    = false
}

variable "cost_centre" {
  description = "The cost centre of the MVE."
  default     = null
  type        = string
}

variable "diversity_zone" {
  description = "The diversity zone of the MVE."
  default     = null
  type        = string
}

variable "hagw_diversity_zone" {
  description = "The diversity zone of the MVE."
  default     = null
  type        = string
}
