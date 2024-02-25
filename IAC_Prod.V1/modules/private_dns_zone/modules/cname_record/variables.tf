variable "cname_records" {
    description = "Provide DNS cname records config"
    type = map
    default = {}
}

variable "tags" {
    description = "Provide tags for pubic IP"
}
