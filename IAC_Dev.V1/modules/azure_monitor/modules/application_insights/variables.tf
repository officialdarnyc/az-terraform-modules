variable "resource_group_name" {
    type        = string
    description = "Existing resource group name for Application Insights"
}
variable "location" {
    type = string
}
variable "application_insights_name" {
    type        = string
    description = "Name for Appication Insights"
}

variable "workspace_id" {
    type        = string
    description = "Id of a log analytics workspace resource"
}

variable "application_type" {
    type        = string
    description = "The type of Application Insights to create. Valid values are ios,java,MobileCenter,Node.js,web,other"
}

variable "daily_data_cap_in_gb" {
    type        = number
    description = "Application Insights component daily data volume cap in GB."
	default = 10
}

variable "daily_data_cap_notifications_disabled" {
    type        = bool
    description = "Specifies if a notification email will be send when the daily data volume cap is met."
	default = true
}

variable "retention_in_days" {
    type        = number
    description = "The retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730"
	default = 90
}

variable "sampling_percentage" {
    type        = number
    description = "The percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
	default = 90
}

variable "disable_ip_masking" {
    type        = bool
    description = "Argument to disable masking and log the real client ip."
	default = false
}

variable "local_authentication_disabled" {
    type        = bool
    description = "Disable Non-Azure AD based Auth.."
	default = false
}
variable "tags" {
    type = map
    description = "Provide tags for application insights"
}