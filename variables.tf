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

variable "wan2_ip" {
  description = "WAN 2 Interface static IP address. Example: \"192.168.2.1/24\"."
  type        = string
  default     = ""
}

variable "wan2_gateway_ip" {
  description = "WAN 2 Interface gateway IP. Example: \"192.168.2.254\"."
  type        = string
  default     = null
}

variable "wan3_ip" {
  description = "WAN 3 Interface static IP address. Example: \"192.168.2.1/24\"."
  type        = string
  default     = ""
}

variable "wan3_gateway_ip" {
  description = "WAN 3 Interface gateway IP. Example: \"192.168.2.254\"."
  type        = string
  default     = null
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
    error_message = "The value of interface_count must be at least 3 and at most 5."
  }
}

variable "megaport_location_mgmt_internet" {
  description = "Overwrite the location for the management internet breakout."
  default     = ""
}
