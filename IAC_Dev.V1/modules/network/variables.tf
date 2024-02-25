variable "tags" {
    description = "Provide tags for Network Security Group"
}
variable "subscription_id" {
    type        = string
    description = "Subscription Id"
}
variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}
variable "location" {
    type = string
    description = "regional location of resource"
    default = "eastus"
}
variable "name"{
    type = string
    description = "Provide virtual network name"
}
variable "address_space" {
    type        = list(string)
    description = "The address space that is used by the virtual network."
}

variable "dns_servers" {
    type        = list(string)
    description = "The DNS servers to be used with vNet. Default is Azure DNS."
    default     = []
}

variable "subnets" {
    type = list(map(string))
    description = "Provide subnet values for given Vnet"
    default = []
}

# ------------- NSG Rules -------------
variable "nsg_rules" {
    type = list(map(string))
    default = []
    description = "Provide list of NSG rules to be applied to each subnet"
}

variable "vpn_gateway_name" {
    type = string
    description = "VPN Gateway name"
}

variable "site_to_site_links" {
    type = list(object({
        type = string
        value = string
    }))
    description = "Provide list of site ip_address/fqdn of local site"
    default = []
}

variable "point_to_site_adress_prefixes" {
    type = list(string)
    description = "Provide Site address_prefixs for remote site"
    default = []
}

variable "point_to_site_vpn_auth_types" {
    type = list(string)
    description = "Provite vpn_auth_types"
    default = []
}

variable "point_to_site_certificate_data" {
    description = "certificate data"
    default = null
}

variable "point_to_site_scale_unit" {
    type = number
    description = "Provite scale_unit"
    default = 1
}

variable "network_peerings" {
    type        = list(map(string))
    description = "network_peerings"
    default     = []
}