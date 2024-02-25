variable "name" {
    type        = string
    description = "container name"
}

variable "storage_account_name" {
    type        = string
    description = "storage account name"
}

variable "container_access_type" {
    type        = string
    description = "type of container blob / private"
    default     = "private"
}

variable "prevent_destroy" {
    type = bool
    description = "Prevent destroy"
    default = false
}