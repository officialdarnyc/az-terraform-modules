variable "peering_name" {
    type = string
    description = "peering_name"
}

variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}

variable "virtual_network_name" {
    type = string
    description = "virtual_network_name"
}

variable "remote_virtual_network_id"{
  type = string
  description = "remote_virtual_network_id"
}

variable "allow_virtual_network_access" {
  type = bool
  default = true
  description = "allow_virtual_network_access"
}

variable "allow_forwarded_traffic" {
  type = bool
  default = true
  description = "allow_forwarded_traffic"
}

variable "allow_gateway_transit" {
  type = bool
  default = false
  description = "allow_gateway_transit"
}

variable "use_remote_gateways" {
  type = bool
  default = false
  description = "use_remote_gateways"
}
