variable "resource_group_name" {
    type        = string
    description = "Existing resource group name for ServiceBus Queue"
}

variable "subscription_name" {
    type        = string
    description = "Name for ServiceBus Topic Subscription"
}

variable "servicebus_topic_name" {
    type        = string
    description = "Name for ServiceBus Topic"
}

variable "servicebus_name" {
    type        = string
    description = "Name for ServiceBus Namespace"
}

variable "enable_partitioning" {
    type        = bool
    description = "Boolean flag which controls whether to enable the queue to be partitioned across multiple message brokers."
	default     = false
}

variable "servicebus_subscription_status" {
    type        = string
    description = "The Status of the Service Topic Subscription. Acceptable values are Active or Disabled"
	default		= "Active"
}

variable "lock_duration" {
    type        = number
    description = "The amount of time that the message is locked for other receivers."
	default     = 1
}

variable "auto_delete_on_idle" {
    type        = string
    description = "Duration of the idle interval after which the Queue is automatically deleted, minimum of 5 minutes."
	default     = null
}

variable "max_size_in_megabytes" {
    type        = string
    description = "Size of memory allocated for the queue."
	default     = "1024"
}

variable "requires_session" {
    type        = bool
    description = "Flag which controls whether the Queue requires sessions. Changing this forces a new resource to be created."
	default     = false
}

variable "default_message_ttl" {
    type        = string
    description = "Timespan duration of the TTL of messages sent to this queue."
	default     = null
}

variable "dead_lettering_on_message_expiration" {
    type        = bool
    description = "Flag which controls whether the Queue has dead letter support when a message expires."
	default     = false
}

variable "dead_lettering_on_filter_evaluation_error" {
    type        = bool
    description = "Flag which controls whether the Subscription has dead letter support on filter evaluation exceptions."
	default     = false
}

variable "max_delivery_count" {
    type        = number
    description = "Time in minutes when a message is automatically dead lettered."
	default     = 10
}

variable "enable_batched_operations" {
    type        = bool
    description = "Flag which controls if server-side batched operations are enabled."
	default     = false
}

variable "forward_to" {
    type        = string
    description = "The name of a Queue or Topic to automatically forward messages to."
	default     = null
}

variable "forward_dead_lettered_messages_to" {
    type        = string
    description = "The name of a Queue or Topic to automatically forward dead lettered messages to."
	default     = null
}