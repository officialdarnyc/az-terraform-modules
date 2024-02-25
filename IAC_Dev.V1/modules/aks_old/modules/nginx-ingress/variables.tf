variable "helm_version" {
    description = "Helm version"
    type = string
    default = "3.0"
}

variable "nginx_version"{
    type        = string
    default     = "latest"
    description = "Provide nginx-controller version "
}

variable "installation_method" {
    description = "Provide installation method, helm/binary/bash etc."
    type = string
    default = "helm"
}

variable "ingress_namespace" {
    description = "Provide nginx ingress controller namespace"
    type = string
    default = "ingress-controller"
}
variable "replica_count" {
    type = number
    description = "Provide replica count"
    default = 2
}
variable "tolerations" {
    type = map(list(map(string)))
    description = "Provide tolerations to be set for ingress controller deployment"
    default = {
        "controller" = [
            {
                key = "pool"
                value = "primarynp"
                operator = "Equal"
                effect = "NoSchedule"
            }
        ]
        "defaultBackend" =[
            {
                key = "pool"
                value = "primarynp"
                operator = "Equal"
                effect = "NoSchedule"
            }
        ]
        "controller.admissionWebhooks.patch" = [
            {
                key = "pool"
                value = "primarynp"
                operator = "Equal"
                effect = "NoSchedule"
            }
        ]
    }
}
variable "ingress_settings" {
    type = map(string)
    description = "Ingress settings"
}
variable "ingress_ip_address" {
    type = string
    description = "Ingress IP address"
    default = null
}
