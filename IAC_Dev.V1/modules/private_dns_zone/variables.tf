variable "resource_group_name" {
    type = string
    description = "Resource group name"
}
variable "private_dns_zone" {
    description = "Provide DNS config to create private dns zone you must provide valid domain name"
    type = string
}
variable "a_records" {
    description = "Provide DNS A records config"
    type = map
    default = {}
}
variable "cname_records" {
    description = "Provide DNS cname records config"
    type = map
    default = {}
}
variable "vnet_links" {
    description = "Provide the list of networks to be linked with dnszone"
    type = map
    default = {}
}
variable "tags" {
    description = "Provide tags for pubic IP"
}
