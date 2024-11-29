variable "name" {
  type = string

}

variable "account" {
  type = string
}

variable "site_id" {
  type = string
}

variable "prepend_as_path" {
  type    = list(number)
  default = null
}

variable "local_as_number" {
  type = number
}

variable "lan_ip" {
  type = string
}

variable "megaport_location" {
  type = string
}

variable "interface_count" {
  type     = number
  default  = 3
  nullable = false

  validation {
    condition     = var.interface_count >= 3 && var.interface_count <= 5
    error_message = "The value of interface_count must be at least 3 and at most 5."
  }

}
