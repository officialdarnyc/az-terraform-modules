variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}

variable "location" {
    type = string
    description = "Regional location of resource"
}

variable "bastion_name"{
    type = string
    description = "Provide Bastion service name"
}

variable "subnet_id"{
    type = string
    description = "Subnet id"
}

variable "tags" {
    description = "Provide tags for the resource group"
}

variable "allocation_method" {
    type = string
    description = "Allocation method"
    default = "Static"
}

variable "sku" {
    type = string
    description = "SKU"
    default = "Standard"
}

variable "copy_paste_enabled" {
    type = bool
    description = "Copy/Paste Enabled?"
    default = true
}

variable "file_copy_enabled" {
    type = bool
    description = "File Copy Enabled?"
    default = true
}

variable "ip_connect_enabled" {
    type = bool
    description = "Connect through IP Enabled?"
    default = true
}

variable "shareable_link_enabled" {
    type = bool
    description = "Shareable Link Enabled?"
    default = false
}

variable "tunneling_enabled" {
    type = bool
    description = "Tunneling Enabled?"
    default = false
}

variable "ip_configuration_name" {
    type = string
    description = "ip configuration name"
    default = false
}

variable "public_ip_address_id" {
    type = string
    description = "public_ip_address_id"
    default = false
}
