variable "application_name" {
    type = string
    description = "Application display name"
}

variable "homepage_url" {
    type = string
    description = "Home page URL"
    default = null
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

variable "service_principal_end_date_relative" {
    type = string
    description = "End Date Relative"
}

variable "service_principal_name" {
    type = string
    description = "Name"
}

variable "service_principal_description" {
    type = string
    description = "Description"
    default = null
}

variable "application_owners" {
    type = list(string)
    description = "Owners"
    default = []
}

variable "service_principal_owners" {
    type = list(string)
    description = "Owners"
    default = []
}

variable "service_principal_app_role_assignment_required" {
    type = bool
    description = "App role assignment required"
    default = false
}

variable "use_existing_service_principal" {
    type = bool
    description = "Use existing principal"
    default = false
}

variable "subscription_id" {
    type = string
    description = "Subscription Id"
}

variable "service_principal_roles" {
    type = list(map(string))
    description = "Roles to be assigned. Keys of map can be one of name, scope, defined_role, description, actions, not_actions, assignable_scopes"
}
