variable "resource_group_name" {
  type = string
  description = "Default resource group name that the network will be created in."
}
variable "name" {
  type = string
  description = "Provide subnet name"
}
variable "virtual_network_name"{
  type = string
  description = "Provide virtual network name."
}
variable "address_prefixes" {
  type = list(string)
  description = "The address space that is used by the subnet."
  default = ["10.0.0.0/20"]
}
variable "service_endpoints" {
  type = list(string)
  description = "The service endpoint is used by the subnet."
  default = null
}
variable "enforce_private_link_endpoint_network_policies" {
  type = bool
  default = false
  description = "Enable or disable network policies for the private link endpoint on the subnet."
}
