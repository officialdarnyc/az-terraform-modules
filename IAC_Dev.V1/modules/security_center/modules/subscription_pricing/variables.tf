variable "tier" {
  type        = string
  description = "security center subscription pricing tier"
  default     = "Standard"
}
variable "resource_type" {
  type        = string
  default     = "VirtualMachines"
  description = "security center subscription pricing resource type"
}
