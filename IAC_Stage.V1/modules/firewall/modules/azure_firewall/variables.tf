variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}

variable "location" {
    type = string
    description = "Regional location of resource"
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

variable "firewall_policy_id"{
    type = string
    description = "firewall_policy_id"
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
