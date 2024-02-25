variable "key_vault_id" {
    type = string
    description = "Azure resource id of keyvault"
}

variable "name" {
    type    = string
    description = "Secret name"
}

variable "value" {
    type    = string
    description = "Secret value"
}

variable "tags" {
    description = "The tags to associate with the secret"
}