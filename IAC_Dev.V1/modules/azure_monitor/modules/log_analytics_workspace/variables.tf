# -------------- Log Analytics Variables ------------
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}
variable "log_analytics_workspace_name" {
  type = string
  description = "provide the log analytics workspace name."
}
variable "location" {
  type = string
  description = "provide the location for log analytics workspace"
  default = "eastus"
}
variable "sku" {
  type        = string
  default     = "pergb2018"
  description = "Provide the laworkspace sku from pergb2018,Free,Standalone,PerNode,Standard,Premium."
}

variable "retention_in_days" {
  description = "The retention time of the Log Analytics workspace"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Provide tags for log analytics workspace"
  
}
