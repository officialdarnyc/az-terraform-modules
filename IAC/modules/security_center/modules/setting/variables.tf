variable "setting_name" {
  type        = string
  default     = "MCAS"
  description = "security center setting name"
}
variable "enable_setting" {
  type        = bool
  default     = true
  description = "enable security center setting"
}
