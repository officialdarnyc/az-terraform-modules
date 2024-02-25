variable "resource_group_name" {
    type        = string
    description = "Existing resource group name for Azure FrontDoor"
}

variable "eventhub_name" {
    type        = string
    description = "Name for the EventHub NameSpace"
}

variable "eventhub_namespace" {
    type        = string
    description = "Name for the EventHub NameSpace"
}

variable "partition_count" {
    type        = number
    description = "Number of partitions created for the Event Hub, allowed values are from 1 to 32 partitions."
    default     = 2
}

variable "message_retention" {
    type        = number
    description = "Number of days to retain the events for this Event Hub, value should be 1 to 7 days"
    default     = 7
}

variable "eventhub_status" {
    type        = string
    description = "Status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled"
    default     = "Active"
}

variable "descriptions" {
    type    = list(map(string))
    default = []
}

