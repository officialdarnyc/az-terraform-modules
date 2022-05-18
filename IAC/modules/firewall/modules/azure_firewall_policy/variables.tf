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

