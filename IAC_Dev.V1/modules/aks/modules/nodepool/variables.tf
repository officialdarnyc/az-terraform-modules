variable "name" {
    type        = string
    description = "Node pool name"
}

variable "kubernetes_cluster_id" {
    type        = string
    description = "AKS Cluster Id"
}

variable "node_count" {
    type        = number
    description = "Orchestrator version"
    default     = 1
}

variable "orchestrator_version" {
    type        = string
    description = "Orchestrator version"
    default     = "1.20.9"
}

variable "os_type" {
    type        = string
    description = "Operating System"
    default     = "Linux"
}

variable "vm_size" {
    type        = string
    description = "Node Size"
    default     = "Standard_D2_v2"
}

variable "availability_zones" {
    type        = string
    description = "Availability zones"
    default     = "1"
}

variable "os_disk_size_gb" {
    type        = number
    description = "Operating system disk size"
    default     = 1024
}

variable "max_pods" {
    type        = number
    description = "Maximum number of pods per agent/node"
    default     = null
}

variable "tags" {
    type        = map(string)
    description = "Tags/Node labels"
    default     = {}
}

variable "vnet_subnet_id" {
    type        = string
    description = "Subnet Id"
    default     = null
}

variable "enable_auto_scaling" {
    type        = bool
    description = "Subnet Id"
    default     = false
}

variable "min_count" {
    type        = number
    description = "Minimum node count"
    default     = 1
}

variable "max_count" {
    type        = number
    description = "Maximum node count"
    default     = 1
}

variable "enable_node_public_ip" {
    type        = bool
    description = "Enable Node Public IP"
    default     = false
}

variable "node_taints" {
    type        = string
    description = "Node taints"
    default     = null
}

