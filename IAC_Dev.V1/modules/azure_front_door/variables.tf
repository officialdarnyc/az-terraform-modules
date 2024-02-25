variable "resource_group_name" {
    type        = string
    description = "Resource group"
}

variable "location" {
    type        = string
    description = "location"
    default     = "eastus"
}

variable "front_door_name" {
    type        = string
    description = "Name for Azure FrontDoor resource"
}

variable "enforce_backend_pools_certificate_name_check" {
    type        = bool
    description = "Enforce backend pool certificate check (true/false) ? Default value is false"
    default     = false
}

variable "load_balancer_enabled" {
    type        = string
    description = "Do you want to enable load balancer ? true/false"
    default     = true
}

variable "routing_rules" {
    type = list(map(string))
    default = []
}

variable "tags" {
    description = "Provide tags for the azure front door resource"
    default = {}
}

variable "default_policy_name" {
    type        = string
    description = "Default WAF policy to apply"
    default     = null
}

variable "attach_log_analytics" {
    type        = bool
    description = "Attach log analytics?"
    default     = false
}

variable "log_analytics_workspace_id" {
    type        = string
    description = "Log analytics workspace id"
    default     = null
}

variable "waf_policies" {
    type = list(map(string))
    default = []
}

variable "waf_policy_managed_rules" {
    type        = list(map(string))
    description = "Managed rules"
    default     = null
}

variable "waf_policy_custom_rules" {
    type        = list(map(string))
    description = "Custom rules"
    default     = null
}

