variable "storage_share_name" {
    type        = string
    description = "storage share name for storage account"
}

variable "storage_account_name" {
    type        = string
    description = "storage account name"
}

variable "quota" {
    type        = number
    description = "number of quotas"
    default     = 50
}

variable "prevent_destroy" {
    type = bool
    description = "Prevent destroy"
    default = false
}