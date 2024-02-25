variable "resource_group_name" {
    type = string
    description = "Resource group name"
}

variable "aks_cluster_name" {
    type = string
    description = "AKS cluster name"
}

variable "service_name" {
    type = string
    description = "Service name"
}

variable "ingress_name" {
    type = string
    description = "Ingress name"
    default = null
}

variable "deployment_name" {
    type = string
    description = "Deployment name"
    default = null
}

variable "namespace_name" {
    type = string
    description = "Namespace name"
}

variable "ingress_namespace_name" {
    type = string
    description = "Ingress Namespace name"
}

variable "deployment_namespace_name" {
    type = string
    description = "Deployment Namespace name"
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

variable "deployment_port" {
    type = number
    description = "Deployment port"
}

variable "ingress_port" {
    type = number
    description = "Ingress port"
    default = 80
}

variable "additional_ports" {
    type = string
    description = "Additional ports e.g. <<port name 1>>#<<ingress port 1>>:<<deployment port 1>>,<<port name 2>>#<<ingress port 2>>:<<deployment port 2>>"
    default = null
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

variable "secret_name" {
    type = string
    description = "Secret name"
}

variable "host_name" {
    type = string
    description = "Host name"
}

variable "tolerations" {
    type = list(map(string))
    description = "Provide tolerations"
    default = []
}

variable "environment_variables" {
    type = list(map(string))
    description = "Environment variables"
    default = []
}

variable "ingress_path" {
    type = string
    description = "Ingress path"
    default = "/"
}

variable "rewrite_path_enabled" {
    type = bool
    description = "Host name"
    default = null
}

variable "deployment_path" {
    type = string
    description = "Service path"
    default = null
}

variable "persistent_volumes" {
    type = list(map(string))
    description = "Provide Persistant Volume details"
    default = []
}

variable "deployment_template_file_name" {
    type = string
    description = "Deployment template file"
    default = null
}

variable "service_template_file_name" {
    type = string
    description = "Service template file"
    default = null
}

variable "ingress_template_file_name" {
    type = string
    description = "Ingress template file"
    default = null
}
variable "ingress_settings" {
    type = map(string)
    description = "Ingress settings"
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
variable "annotations" {
    type = string
    description = "Annotations e.g. <<Annotation 1>>:<<Annotation 1 Value>>,<<Annotation 2>>:<<Annotation 2 Value>>"
    default = null
}