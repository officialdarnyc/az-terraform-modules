variable "name" {
  type = string
  description = "Provide endpoint name"
}
variable "location" {
  type = string
  description = "Provide location of resource"
  default = "eastus"
}
variable "resource_group_name" {
  type = string
  description = "Provide resource group name"
}
variable "subnet_id" {
  type = string
  description = "Provide private endpoint subnet ID"
}
variable "service_connections" {
  description = "Provide list of resources"
  default = []
}
