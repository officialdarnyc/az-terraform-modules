variable "resource_group_name" {
  description = "Default resource group name that the container registry will be created in."
  type = string
}
variable "location" {
  description = "Default location/region for container registry"
  type = string
  default = "eastus"
}
variable "azure_container_registry_name" {
  type        = string
  description = "Provide the name for the container reistry."
}
variable "azure_container_registry_sku" {
  type        = string
  description = "Provide the ACR sku."
  default = "Standard"
}
variable "admin_enabled" {
  description = "Admin access enabled"
  type        = bool
  default = false
}
variable "tags"{
  description = "Provide tags for conatiner registry"
}
