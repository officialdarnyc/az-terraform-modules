variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}

variable "location" {
    type = string
    description = "Regional location of resource"
}

variable "user_managed_identity_name"{
    type = string
    description = "user managed identity name"
}

variable "tags"{
    description = "Provide tags for application gateway"
}