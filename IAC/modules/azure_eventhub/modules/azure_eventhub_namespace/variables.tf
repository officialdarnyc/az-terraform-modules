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

variable "auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace"
  default     = false
}

variable "dedicated_cluster_id" {
  type        = string
  description = "The ID of the EventHub Dedicated Cluster where this Namespace should created"
  default     = null
}

variable "maximum_throughput_units" {
  type        = string
  description = "Maximum number of throughput units when Auto Inflate is Enabled"
  default     = null
}

variable "zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)"
  default     = false
}

variable "rulesets" {
  type    = list(map(string))
  default = []
}

variable "identities" {
  type    = list(map(string))
  default = []
}

variable "tags" {
  default = {}
}