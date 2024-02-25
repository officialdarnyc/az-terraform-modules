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
    description = "Service name"
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

variable "backoff_limit" {
    type = number
    description = "Backoff Limit"
    default = 3
}

variable "suspend" {
    type = bool
    description = "Suspend"
    default = null
}

variable "parallelism" {
    type = number
    description = "Parallelism"
    default = null
}

variable "completions" {
    type = number
    description = "Completions"
    default = null
}

variable "ttl_seconds_after_finished" {
    type = number
    description = "Completions"
    default = null
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
