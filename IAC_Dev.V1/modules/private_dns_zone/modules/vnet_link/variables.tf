variable "vnet_links" {
  description = "Provide the network link config for dnszone."
  type = map
  default = {}
}
variable "tags" {
    description = "Provide tags for pubic IP"
}
