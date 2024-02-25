variable "resource_group_name"{
    type = string
    description = "Provide resource group name"
}
variable "location"{
    type = string
    description = "Provide resource group location"
    default = "eastus"
}
variable "tags"{
    description = "Provide tags for the resource group"
}

variable "prevent_destroy" {
    type = bool
    description = "Prevent destroy"
    default = false
}