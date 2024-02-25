variable "resource_group_name" {
    description = "Resource group name"
    type = string
}

variable "location" {
    description = "Location/Region"
    type = string
}

variable "name" {
    description = "Name"
    type = string
}

variable "subnet_id" {
    description = "Subnet Id"
    type = string
}

variable "sku" {
    description = "SKU"
    type = string
    default = "Standard_DS1_v2"
}

variable "username" {
    description = "Administrator login name"
    type = string
}

variable "password" {
    description = "Administrator login password"
    type = string
}

variable "os" {
    description = "Operating system"
    type = string
    default = "windows"
}

variable "address_allocation" {
    description = "IP Address Allocation Type"
    type = string
    default = "Dynamic"
}

variable "delete_os_disk_on_termination" {
    description = "Delete OS Disk on termination"
    type = bool
    default = true
}

variable "delete_data_disks_on_termination" {
    description = "Delete OS Disk on termination"
    type = bool
    default = true
}

variable "image_publisher" {
    description = "Image publisher"
    type = string
    default = null
}

variable "image_offer" {
    description = "Image offer"
    type = string
    default = null
}

variable "image_sku" {
    description = "Image SKU"
    type = string
    default = null
}

variable "image_version" {
    description = "Image Version"
    type = string
    default = null
}

variable "disk_type" {
    description = "Disk type"
    type = string
    default = null
}

variable "computer_name" {
    description = "Computer/Host name"
    type = string
    default = null
}

variable "disable_password_authentication" {
    description = "Disable password authentication"
    type = bool
    default = false
}

variable "provision_vm_agent" {
    description = "Provision VM Agent"
    type = bool
    default = true
}

variable "enable_automatic_upgrades" {
    description = "Enable auto upgrades"
    type = bool
    default = true
}

variable "timezone" {
    description = "Timezone"
    type = string
    default = null
}

variable "image_uri" {
    description = "Image URI"
    type = string
    default = null
}

variable "image_uri_version" {
    description = "Image URI Version"
    type = string
    default = null
}

variable "tags" {
    description = "Tags"
}
