variable "resource_group_name" {
  type = string
  description = "Default resource group name that the network will be created in."
}
variable "location" {
  type = string
  description = "This is the regional location of resource."
}
variable "network_security_group_name" {
  type = string
  description = "Provide name of network security group"
}
variable "tags"{
  type = map
  description = "Provide tags for network security group"
}

