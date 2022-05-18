variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}

variable "location" {
    type = string
    description = "Regional location of resource"
}

variable "firewall_policy_id" {
    type = string
    description = "firewall_policy_id"
}

variable "firewall_policy_rule_name" {
    type = string
    description = "firewall_policy_rule_name"
}

variable "firewall_policy_rule_priority" {
    type = string
    description = "firewall_policy_rule_priority"
}

variable "application_rule_collection" {
    description = "firewall_policy_rule_application_rule_collection"
}

variable "network_rule_collection" {
    description = "network_rule_collection"
}

variable "nat_rule_collection" {
    description = "nat_rule_collection"
}
