# -------------- Log Analytics Variables ------------
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type = string
  description = "provide the location for log analytics workspace"
  default = "eastus"
}

variable "solution_name" {
  type  = string
  description = "Container insights solution name"
  default = "ContainerInsights"
}
variable "plan" {
  type = map
  description = "Provide the plan of container insights"
  default = {
    publisher = "Microsoft"
    product = "OMSGallery/ContainerInsights"
  }
}

variable "workspace_resource_id" {
    type        = string
    description = "Id of a log analytics workspace resource"
}

variable "workspace_name" {
  type = string
  description = "provide the log analytics workspace name."
}

variable "tags" {
  description = "Provide tags for log analytics workspace"
  
}
