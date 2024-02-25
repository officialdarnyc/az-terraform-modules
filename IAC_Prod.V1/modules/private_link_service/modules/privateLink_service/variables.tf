variable "privateLink_service_name" {
  type        = string
  description = "privateLink service name"
}
variable "resource_group_name" {
  type        = string
  description = "resource group name"
}
variable "location" {
  type        = string
  description = "location for private link service name"
}
variable "load_balancer_frontend_ip_configuration_ids" {
  type        = string
  description = "(Required) A list of Frontend IP Configuration ID's from a Standard Load Balancer, where traffic from the Private Link Service should be routed. You can use Load Balancer Rules to direct this traffic to appropriate backend pools where your applications are running."
  # [azurerm_lb.example.frontend_ip_configuration.0.id]
}
variable "service" {
  type    = list(map(string))
  default = []
}
variable "nat_ip_configuration_name" {
  type        = string
  description = "nat ip configuration for mysql private link service"
}
variable "subnet_id" {
  type        = string
  description = "(Required) Specifies the ID of the Subnet which should be used for the Private Link Service"
}
variable "primary" {
  type        = bool
  default     = true
  description = "(Required) Is this is the Primary IP Configuration? Changing this forces a new resource to be created"
}
variable "enable_proxy_protocol" {
  type        = bool
  default     = false
  description = "(Optional) Should the Private Link Service support the Proxy Protocol? Defaults to false"
}
variable "tags" {
  description = "tags for private link service"
}
