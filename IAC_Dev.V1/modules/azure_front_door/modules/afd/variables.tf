variable "resource_group_name" {
    type        = string
    description = "Existing resource group name for Azure FrontDoor"
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

variable "default_policy_id" {
    type = string
    description = "Default policy id"
    default = null
}

variable "tags" {
    description = "Provide tags for the azure front door resource"
    default = {}
}