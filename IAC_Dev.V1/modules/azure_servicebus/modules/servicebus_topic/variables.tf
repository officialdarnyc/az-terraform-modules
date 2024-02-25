variable "resource_group_name" {
    type        = string
    description = "Existing resource group name for ServiceBus Topic"
}

variable "servicebus_topic_name" {
    type        = string
    description = "Name for ServiceBus Topic"
}

variable "servicebus_name" {
    type        = string
    description = "Name for ServiceBus Namespace"
}

variable "servicebus_topic_status" {
    type        = string
    description = "The Status of the Service Bus Topic. Acceptable values are Active or Disabled"
	default		= "Active"
}

variable "auto_delete_on_idle" {
    type        = string
    description = "Duration of the idle interval after which the Topic is automatically deleted, minimum of 5 minutes."
	default     = null
}

variable "default_message_ttl" {
    type        = string
    description = "Timespan duration of the TTL of messages sent to this queue."
	default     = null
}

variable "duplicate_detection_history_time_window" {
    type        = string
    description = "The ISO 8601 timespan duration during which duplicates can be detected."
	default     = null
}

variable "enable_batched_operations" {
    type        = bool
    description = "Flag which controls if server-side batched operations are enabled."
	default     = false
}

variable "enable_express" {
    type        = bool
    description = "flag which controls whether Express Entities are enabled."
	default     = false
}


variable "enable_partitioning" {
    type        = bool
    description = "Boolean flag which controls whether to enable the topic to be partitioned across multiple message brokers."
	default     = true
}

variable "max_size_in_megabytes" {
    type        = string
    description = "Size of memory allocated for the queue."
	default     = "1024"
}

variable "requires_duplicate_detection" {
    type        = bool
    description = "Flag which controls whether the Queue requires duplicate detection. Changing this forces a new resource to be created."
	default     = false
}

variable "support_ordering" {
    type        = bool
    description = "Flag which controls whether the Topic supports ordering."
	default     = false
}