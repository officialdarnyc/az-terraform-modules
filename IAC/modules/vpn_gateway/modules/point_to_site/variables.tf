variable "resource_group_name" {
  type = string
  description = "Provite resource_group_name"
}
variable "location" {
  type = string
  description = "Provite location name"
  default = "eastus"
}
variable "point_to_site_conn_name" {
  type = string
  description = "Provite point to vpn connection name"
}
variable "vpn_auth_types" {
  type = list(string)
  description = "Provite vpn_auth_types"
  default = []
}
variable "certificate_data" {
  description = "certificate data"
  default = null
}
variable "vpn_gateway_hub_id" {
  type = string
  description = "Provite vpn gateway hub id"
}
variable "scale_unit" {
  type = number
  description = "Provite scale_unit"
  default = 1
}
variable "address_prefixes" {
  type = list(string)
  description = "Provite address prefixes for point to site vpn connection"
}

variable "tags" {
    description = "VPN gateway tags"
}
