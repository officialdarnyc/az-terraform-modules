variable "application_id" {
    type = string
    description = "Azure AD Appliation Id"
}

variable "application_object_id" {
    type = string
    description = "Azure AD Appliation Object Id"
}

variable "end_date_relative" {
    type = string
    description = "End Date Relative"
}

variable "name" {
    type = string
    description = "Name"
}

variable "description" {
    type = string
    description = "Description"
}

variable "owners" {
    type = list(string)
    description = "Owners"
}

variable "app_role_assignment_required" {
    type = bool
    description = "App role assignment required"
    default = false
}

variable "use_existing" {
    type = bool
    description = "Use existing principal"
    default = false
}

variable "subscription_id" {
    type = string
    description = "Subscription Id"
    default = null
}

variable "roles" {
    type = list(map(string))
    description = "Roles to be assigned. Keys of map can be one of name, scope, defined_role, description, actions, not_actions, assignable_scopes"
}
