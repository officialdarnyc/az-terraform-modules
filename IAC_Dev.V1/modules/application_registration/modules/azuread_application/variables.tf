variable "application_name" {
    type = string
    description = "Application display name"
}

variable "homepage_url" {
    type = string
    description = "Home page URL"
    default = null
}

variable "owners" {
    type = list(string)
    description = "Owners"
}

variable "logout_url" {
    type = string
    description = "Logout URL"
    default = null
}

variable "required_resource_accesses" {
    type = list(map(string))
    description = "Required resource access"
    default = []
}

variable "redirect_uris" {
    type = list(string)
    description = "Logout URL"
    default = []
}

variable "access_token_issuance_enabled" {
    type = bool
    description = "Access token issuance enabled"
    default = false
}

variable "id_token_issuance_enabled" {
    type = bool
    description = "Id token issuance enabled"
    default = false
}
