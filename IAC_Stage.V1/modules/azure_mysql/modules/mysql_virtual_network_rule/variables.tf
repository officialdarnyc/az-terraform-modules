variable "name" {
    type        = string
    description = "Network rule name"
}
variable "resource_group_name" {
    type = string
}
variable "server_name" {
    type = string
}
variable "subnet_id" {
    type        = string
    description = "subnet id for virtual network"
}
