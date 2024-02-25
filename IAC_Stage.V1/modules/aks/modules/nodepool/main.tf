resource "azurerm_kubernetes_cluster_node_pool" "aks_node_pool" {
    name                  = var.name
    kubernetes_cluster_id = var.kubernetes_cluster_id
    orchestrator_version  = var.orchestrator_version
    node_count            = var.node_count
    os_type               = var.os_type
    vm_size               = var.vm_size
    os_disk_size_gb       = var.os_disk_size_gb
    max_pods              = var.max_pods
    node_labels           = var.tags
    node_taints           = var.node_taints == null ? null : split(",", var.node_taints == null ? "" : var.node_taints)
    vnet_subnet_id        = var.vnet_subnet_id
    enable_auto_scaling   = var.enable_auto_scaling
    min_count             = var.enable_auto_scaling == true ? var.min_count : null
    max_count             = var.enable_auto_scaling == true ? var.max_count : null
    enable_node_public_ip = var.enable_node_public_ip
    availability_zones    = split(",", var.availability_zones == null || length(var.availability_zones) == 0 ? "1" : var.availability_zones)
}
