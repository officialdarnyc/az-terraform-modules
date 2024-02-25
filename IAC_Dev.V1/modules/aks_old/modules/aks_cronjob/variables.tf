variable "resource_group_name" {
    type = string
    description = "Resource group name"
}

variable "aks_cluster_name" {
    type = string
    description = "AKS cluster name"
}

variable "job_name" {
    type = string
    description = "Job name"
}

variable "namespace_name" {
    type = string
    description = "Namespace name"
}

variable "image" {
    type = string
    description = "Image"
}

variable "command" {
    type = string
    description = "Image"
}

variable "restart_policy" {
    type = string
    description = "Image"
    default = "OnFailure"
}

variable "boot_time" {
    type = number
    description = "Boot time i.e. Starting deadline time in seconds"
    default = 0
}

variable "concurrency_policy" {
    type = string
    description = "Concurrency policy"
    default = "Allow"
}

variable "schedule" {
    type = string
    description = "Job schedule"
}

variable "environment_variables" {
    type = list(map(string))
    description = "Environment variables"
    default = []
}

variable "template_file_name" {
    type = string
    description = "Template file"
    default = null
}

variable "tolerations" {
    type = list(map(string))
    description = "Provide tolerations"
    default = []
}

variable "persistent_volumes" {
    type = list(map(string))
    description = "Provide Persistant Volume details"
    default = []
}

variable "timezone" {
    type = string
    description = "Timezone"
    default = null
}

variable "timezone_location" {
    type = string
    description = "Timezone location"
    default = null
}
