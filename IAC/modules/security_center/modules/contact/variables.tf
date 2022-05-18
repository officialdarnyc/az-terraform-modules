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
  description = "security center notification alert"
  default     = true
}
variable "alerts_to_admins" {
  type        = bool
  description = "security center alert to admin"
  default     = true
}
