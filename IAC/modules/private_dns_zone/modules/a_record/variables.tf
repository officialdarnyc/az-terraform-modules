variable "a_records" {
    description = "Provide DNS A records config"
    type = map
    default = {}
}
variable "tags" {
    description = "Provide tags for pubic IP"
}
