variable "resource_group_name" {
    type = string
    description = "Resource group name"
}

variable "aks_cluster_name" {
    type = string
    description = "AKS cluster name"
}

variable "deployment_name" {
    type = string
    description = "Deployment name"
}

variable "namespace_name" {
    type = string
    description = "Namespace name"
}

variable "image" {
    type = string
    description = "Image"
}

variable "replica_count" {
    type = number
    description = "Replica count"
    default = 1
}

variable "max_replica_count" {
    type = number
    description = "Max Replica count"
    default = null
}

variable "target_cpu_utilization" {
    type = number
    description = "Target CPU utilization for HPA"
    default = null
}

variable "scale_down_period" {
    type = number
    description = "Scale down period"
    default = null
}

variable "deployment_hpa_template_file_name" {
    type = string
    description = "Deployment HPA template"
    default = null
}

variable "port" {
    type = number
    description = "Port"
}

variable "liveness_probe_path" {
    type = string
    description = "Liveness probe path"
    default = "/"
}

variable "readiness_probe_path" {
    type = string
    description = "Readiness probe path"
    default = "/"
}

variable "tolerations" {
    type = list(map(string))
    description = "Provide tolerations"
    default = []
}

variable "additional_ports" {
    type = list(map(string))
    description = "Additional ports. Every config should contain two keys - name & deployment_port:"
    default = []
}

variable "environment_variables" {
    type = list(map(string))
    description = "Environment variables"
    default = []
}

variable "persistent_volumes" {
    type = list(map(string))
    description = "Provide Persistant Volume details"
    default = []
}

variable "template_file_name" {
    type = string
    description = "Template file"
    default = null
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

variable "max_cpu" {
    type = string
    description = "Max CPU"
    default = null
}
variable "min_cpu" {
    type = string
    description = "Min CPU"
    default = null
}
variable "max_memory" {
    type = string
    description = "Max Memory"
    default = null
}
variable "min_memory" {
    type = string
    description = "Min Memory"
    default = null
}

variable "readiness_probe_period" {
    type = string
    description = "Readiness Probe Period"
    default = null
}

variable "readiness_probe_timeout" {
    type = string
    description = "Readiness Probe Timeout"
    default = null
}

variable "readiness_probe_failure_threshold" {
    type = string
    description = "Readiness Failure Threshold"
    default = null
}

variable "liveness_probe_period" {
    type = string
    description = "Liveness Probe Period"
    default = null
}

variable "liveness_probe_timeout" {
    type = string
    description = "Liveness Probe Timeout"
    default = null
}

variable "liveness_probe_failure_threshold" {
    type = string
    description = "Liveness Failure Threshhold"
    default = null
}
