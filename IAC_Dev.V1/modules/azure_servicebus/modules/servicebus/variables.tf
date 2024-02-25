variable "resource_group_name" {
    type        = string
    description = "Existing resource group name for Application Insights"
}
variable "location" {
    type = string
}
variable "servicebus_name" {
    type        = string
    description = "Name for ServiceBus Namespace"
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

variable "zone_redundant" {
    type        = bool
    description = "Whether or not this resource is zone redundant."
	default     = false
}

variable "tags" {
    description = "Provide tags for application insights"
    default     = {}
}