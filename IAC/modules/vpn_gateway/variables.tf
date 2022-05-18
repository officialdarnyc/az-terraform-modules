# ------------ Common -------------
variable "resource_group_name" {
    type = string
    description = "Provide resource group name"
}
variable "location" {
    type = string
    description = "Provide location name"
    default = "eastus"
}

variable "tags" {
    description = "VPN gateway tags"
}



# ------------ VPN Gateway -------------
variable "vpn_gateway_name" {
    type = string
    description = "Provide VPN gateway name"
}

variable "hub_address_prefix" {
    type = string
    description = "Provide HUB address_prefix for hub network"
}

# ------------ Site to Site VPN -------------
variable "site_to_site_connection_name" {
    type = string
    description = "Site2Site Connecton Name"
    default = null
}

variable "links" {
    type = list(object({
        type = string
        value = string
    }))
    description = "Provide list of site ip_address/fqdn of local site"
    default = []
}

# ------------ Point to Site VPN -------------
variable "point_to_site_connection_name" {
    type = string
    description = "Site2Site Connecton Name"
    default = null
}

variable "site_adress_prefixes" {
    type = list(string)
    description = "Provide Site address_prefixs for remote site"
    default = []
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

variable "scale_unit" {
    type = number
    description = "Provite scale_unit"
    default = 1
}
