variable "log_analytics_workspace_name" {
  type        = string
  description = "security center log analytics name"
}
variable "location" {
  type        = string
  description = "security center location"
}
variable "resource_group_name" {
  type        = string
  description = "security center resource group name"
}
variable "tags" {
  description = "Provide tags for log analytics"
}
variable "scope" {
  type        = string
  description = "security center scope"
}
# variable "workspace_id" {
#   type        = string
#   description = "security center workspace_id"
# }

variable "tier" {
  type        = string
  default     = "Standard"
  description = "security center tier"
}
variable "resource_type" {
  type        = string
  default     = "VirtualMachines"
  description = "security center resource_type"
}
variable "email" {
  type        = string
  description = "security center email"
}
variable "phone" {
  type        = string
  description = "security center phone"
}
variable "alert_notifications" {
  type        = bool
  default     = true
  description = "security center alert_notification"
}
variable "alerts_to_admins" {
  type        = bool
  default     = true
  description = "security center alert_to_admins"
}
variable "setting_name" {
  type        = string
  default     = "MCAS"
  description = "security center security_center_setting_name"
}
variable "enable_setting" {
  type        = string
  default     = true
  description = "security center enable_security_center_setting"
}

variable "enable_auto_provisioning" {
  type        = string
  description = "security center enable security center auto provisioning"
  default     = "On"
}
