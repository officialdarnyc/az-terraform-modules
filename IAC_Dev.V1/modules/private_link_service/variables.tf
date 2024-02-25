variable "endpoint_name" {
  type        = string
  description = "Provide endpoint name"
}
variable "location" {
  type        = string
  description = "Provide resource location"
  default     = "eastus"
}
variable "resource_group_name" {
  type        = string
  description = "Provide resource group name"
}
variable "subnet_id" {
  type        = string
  description = "Provide subnet id"
}
variable "service_connections" {
  default     = []
  description = "Provide resources service connection detail"
}
