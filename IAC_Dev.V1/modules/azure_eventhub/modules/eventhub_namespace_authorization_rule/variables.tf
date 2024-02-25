variable "resource_group_name" {
  type        = string
  description = "Existing resource group name for Azure FrontDoor"
}

variable "namespace_auth_rule_name" {
  type        = string
  description = "Name for the Authorization Rule NameSpace"
}

variable "eventhub_namespace" {
  type        = string
  description = "Name for the EventHub NameSpace"
}

variable "listen" {
  type        = bool
  description = "Grants listen access to this this Authorization Rule"
  default     = false
}

variable "send" {
  type        = bool
  description = "Grants send access to this this Authorization Rule."
  default     = false
}

variable "manage" {
  type        = bool
  description = "Grants manage access to this this Authorization Rule"
  default     = false
}


