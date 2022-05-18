variable "tags" {
    description = "Provide tags for Network Security Group"
}
variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}
variable "location" {
    type = string
    description = "regional location of resource"
    default = "eastus"
}

variable "name"{
  type = string
  description = "Provide virtual network name"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/20"]
}

variable "dns_servers" {
  type        = list(string)
  description = "The DNS servers to be used with vNet. Default is Azure DNS."
  default     = ["168.63.129.16"]
}
