variable "mysql_firewall_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "server_name" {
  type = string
}
variable "start_ip_address" {
  type    = string
  default = "0.0.0.0"
}
variable "end_ip_address" {
  type    = string
  default = "0.0.0.0"
}
