variable "resource_group_name" {
    type            = string
    description     = "Existing resource group name for ServiceBus Topic"
}

variable "location" {
    type            = string
    description     = "Location of the namespace"
}		

variable "servicebus_name" {
    type            = string
    description     = "Name for ServiceBus Namespace"
    default=null
}

variable "sku" {
    type        = string
    description = "Tier for ServiceBus"
	default     = "Standard"
}

variable "capacity" {
    type        = number
    description = "Capacity of ServiceBus"
	default		= 0
}


variable "topics" {
    type            = list(map(string))
    description     = "ServiceBus Topics"
    default         = []
}

variable "queues" {
    type            = list(map(string))
    description     = "ServiceBus Queues"
    default         = []
}

variable "subscriptions" {
    type            = list(map(string))
    description     = "ServiceBus Subscriptions"
    default         = []
}

variable "tags" {
    description     = "Provide tags for resources"
    default         = {}
}


variable "log_analytics_workspace_id" {
    type    = string
    default = null
}

variable "diagnostic_setting_name" {
    type    = string
    default = null
}

variable "servicebus_diagnostics_setting_enabled" {
    type = bool
    description = "Enable Diagnostics setting"
    default = false
}


