variable "resource_group_name"{
    type = string
    description = "Provide resource group name"
}

variable "location"{
    type = string
    description = "Provide resource group location"
    default = "eastus"
}

variable "route_table_name" {
    type = string
    description = "route_table_name"
}

variable "routes" {
    type = list(map(string))
    description = "route_table_name"
}
