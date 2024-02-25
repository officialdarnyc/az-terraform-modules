# ----------------- Resource Group Name --------------
variable "resource_group_name" {
    type = string
    description = "Resource group name of NSG rule"
}
# ----------------- Network Security Group Name --------------
variable "network_security_group_name" {
    type = string
    description = "Name of Network Security Group"
}
# ----------------- NSG rule setup attributes --------------
variable "nsg_rule_name" {
    type = string
    description = "Name of the NSG rule"
}
variable "nsg_rule_priority" {
    type = number
    description = "Prority of the NSG rule"
}
variable "nsg_rule_direction" {
    type = string
    description = "Direction of NSG rule (Inbound/Outbound)"
}
variable "nsg_rule_access" {
    type = string
    description = "Access type of NSG rule (Allow, Denied etc.)"
}
variable "nsg_rule_protocol" {
    type = string
    description = "Protocol values for NSG rule"
}
variable "nsg_rule_source_port_range" {
    type = string
    default = null
    description = "Source port range for NSG rule"
}
variable "nsg_rule_source_port_ranges" {
    type = list(string)
    default = null
    description = "Source port range for NSG rule"
}
variable "nsg_rule_destination_port_range" {
    type = string
    default = null
    description = "Destination port range for NSG rule"
}
variable "nsg_rule_destination_port_ranges" {
    type = list(string)
    default = null
    description = "Destination port ranges for NSG rule"
}
variable "nsg_rule_source_address_prefix" {
    type = string
    default = null
    description = "Source address prefix for NSG rule setup"
}
variable "nsg_rule_source_address_prefixes" {
    type = list(string)
    default = null
    description = "Source address prefix for NSG rule setup"
}
variable "nsg_rule_destination_address_prefix" {
    type = string
    default = null
    description = "Destination address prefix for NSG rule"
}
variable "nsg_rule_destination_address_prefixes" {
    type = list(string)
    default = null
    description = "Destination address prefix for NSG rule"
}
