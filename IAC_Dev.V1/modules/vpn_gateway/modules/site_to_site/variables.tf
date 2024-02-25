variable "resource_group_name" {
  type = string
  description = "Provide resource group name"
}
variable "location" {
  type = string
  description = "Provide location name"
  default = "eastus"
}
variable "name" {
  type = string
  description = "Provide name"
}
variable "virtual_wan_id" {
  type = string
  description = "Provide virtual WAN Id of VPN gateway"
}
variable "links" {
  type = list(object({
      type = string
      value = string
  }))
  description = "Provide list of site ip_address/fqdn of local site"
  default = []
}

variable "tags" {
    description = "VPN gateway tags"
}
