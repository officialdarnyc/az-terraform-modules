variable "name" {
    type        = string
    description = "Resource group name"
}

variable "resource_group_name" {
    type        = string
    description = "Resource group name"
}

variable "enabled" {
    type        = bool
    description = "Resource group name"
    default     = true
}

variable "mode" {
    type        = string
    description = "Resource group name"
    default     = null
}

variable "redirect_url" {
    type        = string
    description = "Resource group name"
    default     = null
}

variable "custom_block_response_status_code" {
    type        = string
    description = "Block response status code"
    default     = "403"
}

variable "custom_block_response_body" {
    type        = string
    description = "Block response body"
    default     = null
}

variable "managed_rules" {
    type        = list(map(string))
    description = "Managed rules"
    default     = []
}

variable "custom_rules" {
    type        = list(map(string))
    description = "Custom rules"
    default     = []
}

variable "tags" {
  description = "Provide tags for pubic IP"
}
