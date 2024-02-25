variable "frontend_endpoint_name" {
    type        = string
    description = "Frontend Point"
}

variable "certificate_enabled" {
    type        = bool
    description = "Certificate Enabled"
    default      = true
}

variable "certificate_version" {
    type        = string
    description = "Certificate Version"
    default      = "Latest"
}

variable "certificate_secret" {
    type        = bool
    description = "Certificate Secret"
}

variable "certificate_key_vault" {
    type        = string
    description = "Certificate Key Vault Name"
}

variable "certificate_source" {
    type        = bool
    description = "Certificate Secret"
    default     = "AzureKeyVault"
}
