variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}



variable "location" {
    type = string
    description = "Regional location of resource"
}

variable "firewall_policyname"{
    type = string
    description = "firewall_policyname"
}

variable "firewall_policy_sku"{
    type = string
    description = "firewall_policy_sku"
}

variable "firewall_name"{
    type = string
    description = "firewall_name"
}

variable "firewall_sku_name"{
    type = string
    description = "firewall_sku_name"
}

variable "sku_tier"{
    type = string
    description = "sku_tier"
}

variable "fw_ip_config_name"{
    type = string
    description = "fw_ip_config_name"
}

variable "fw_ip_config_subnet_id"{
    type = string
    description = "fw_ip_config_subnet_id"
}

variable "fw_ip_config_pipid"{
    type = string
    description = "fw_ip_config_pipid"
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
