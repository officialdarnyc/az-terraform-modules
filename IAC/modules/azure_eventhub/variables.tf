variable "resource_group_name" {
    type        = string
    description = "Existing resource group name for Azure FrontDoor"
}

variable "location" {
    type        = string
    description = "Location"
}

variable "eventhub_namespace" {
    type        = string
    description = "Name for the EventHub NameSpace"
    default = null
}

variable "name" {
    type        = string
    description = "Event hub name"
    default = null
}

variable "partition_count" {
    type        = number
    description = "Event hub partition count"
    default = 2
}


variable "message_retention" {
    type        = number
    description = "Message retention period"
    default = 7
}

variable "status" {
    type        = string
    description = "Event hub status"
    default = "Active"
}

variable "descriptions" {
    type    = list(map(string))
    default = []
}

variable "sku" {
    type        = string
    description = "Tier for EventHub NameSpace"
    default     = "Standard"
}

variable "capacity" {
    type        = number
    description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace"
    default     = 1
}

variable "rulesets" {
    type    = list(map(string))
    default = []
}

variable "identities" {
    type    = list(map(string))
    default = []
}

variable "eventhubs" {
    type    = list(map(string))
    default = []
}

variable "namespace_authorization_rules" {
    type    = list(map(string))
    default = []
}

variable "eventhub_authorization_rules" {
    type    = list(map(string))
    default = []
}

variable "tags" {
    default = {}
}


variable "log_analytics_workspace_id" {
    type    = string
    default = null
}

variable "diagnostic_setting_name" {
    type    = string
    default = null
}

variable "eventhub_diagnostics_setting_enabled" {
    type = bool
    description = "Enable Diagnostics setting"
    default = false
}