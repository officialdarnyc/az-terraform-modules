variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}

variable "location" {
    type = string
    description = "Regional location of resource"
}

variable "public_ip_name"{
    type = string
    description = "Public ip name"
}

variable "tags" {
    description = "Provide tags for the resource group"
}

variable "allocation_method" {
    type = string
    description = "allocation method"
    default = "Static"  
}

variable "sku" {
    type = string
    description = "SKU"
    default = "Standard"
}
