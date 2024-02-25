variable "resource_group_name" {
    type        = string
    description = "Existing resource group name for Application Insights"
}

variable "location" {
    type = string
    description = "Location"
}

variable "tags" {
    description = "Provide tags for application insights"
    default = {}
}

variable "log_analytics_workspace_name" {
    type = string
    description = "Log Analytics WorkSpace name"
    default = null
}

variable "solution_name" {
    type = string
    description = "Log Analytics Solution name"
    default = null
}
variable "application_insights_name" {
    type = string
    description = "Application Insights name"
    default = null
}

variable "solutions" {
    type        = list(map(string))
    description = "Map for log analytics solutions"
    default     = []
}

variable "application_insights" {
    type        = list(map(string))
    description = "Map for log application insights"
    default     = []
}

variable "application_type" {
    type = string
    description = "Application Type"
    default = "web"
}
