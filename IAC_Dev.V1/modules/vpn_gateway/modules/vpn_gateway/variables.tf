variable "resource_group_name" {
  type = string
  description = "Provide resource group name"
}
variable "location" {
  type = string
  description = "Provide location name"
  default = "eastus"
}
variable "address_prefix" {
  type = string
  description = "Provide address_prefix for hub network"
  default = "10.52.0.0/23"
}
variable "vpn_gateway_name" {
  type = string
  description = "Provide VPN gateway name"
}
variable "tags" {
  description = "Tags for VPN Gateway"
}