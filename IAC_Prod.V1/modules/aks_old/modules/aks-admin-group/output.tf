output "admin_id" {
  value = "${azuread_group.aks_administrators.object_id}"
}

# output "subnet_id" {
#   value = "${azurerm_kubernetes_cluster.azure-k8s.default_node_pool.0.vnet_subnet_id}"
# }