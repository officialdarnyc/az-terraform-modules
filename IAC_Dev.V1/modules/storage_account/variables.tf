variable "resource_group_name" {
    type        = string
    description = "resource group name"
}

variable "location" {
    type        = string
    description = "location"
}

variable "storage_account_name" {
    type        = string
    description = "storage account name"
}

variable "account_tier" {
    type        = string
    description = "account tier : standard"
    default     = "standard"
}

variable "account_replication_type" {
    type        = string
    description = "account replication : LRS"
    default     = "LRS"
}

variable "tags" {
    description = "provide tags for tags"
}

variable "file_shares" {
    type = list(map(string))
    description = "provide tags for file shares"
    default = []
}

variable "containers" {
    type = list(map(string))
    description = "provide tags for containers"
    default = []
}

variable "prevent_destroy" {
    type = bool
    description = "Prevent destroy"
    default = false
}

variable "storage_account_private_link_enabled" {
    type = bool
    description = "Enable private link endpoint for storage account blob"
    default = false
}

variable "storage_account_private_link_endpoint_name" {
    type = string
    description = "Private link endpoint name storage account blob"
    default = null
}

variable "storage_account_private_link_subnet_id" {
    type = string
    description = "Private link subnet id storage account blob"
    default = null
}

variable "subresource_name" {
    description = "Subresource name for private end point"
    default = []
}

