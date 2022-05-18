variable "loadbalancer_name" {
  type        = string
  description = "load balancer name"
}
variable "sku_name" {
  type        = string
  default     = "Standard"
  description = "(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic and Standard. Defaults to Basic"
}
variable "location" {
  type        = string
  description = "location of loadbalancer"
}
variable "resource_group_name" {
  type        = string
  description = "resource group name for load balancer"
}
variable "frontend_ip_configuration_name" {
  type        = string
  description = "(Required) Specifies the name of the frontend ip configuration"
}
variable "availability_zone" {
  type        = string
  default     = "Zone-Redundant"
  description = "(optional) describe your variable"
}
variable "public_ip_address_id" {
  type        = string
  description = "(Optional) The ID of a Public IP Address which should be associated with the Load Balancer"
}
variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet which should be associated with the IP Configuration"
}
variable "private_ip_address" {
  type        = string
  description = "(Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned"
}
variable "private_ip_address_allocation" {
  type        = string
  default     = "Static"
  description = "(optional) describe your variable"
}
variable "private_ip_address_version" {
  type        = string
  default     = "IPv4"
  description = "(optional) describe your variable"
}
variable "tags" {
  description = "tags for load balancer"
}
