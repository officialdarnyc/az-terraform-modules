# module "azuread_group" {
#   source          = "./modules/aks-admin-group"
#   aks_admin       = var.aks_admin
  
# }

module "aks" {
    source = "./modules/cluster"

    resource_group_name               = var.resource_group_name
    location                          = var.location
    aks_cluster_name                  = var.aks_cluster_name
    repository_name                   = var.repository_name
    dns_prefix                        = var.dns_prefix
    private_dns_zone_id               = var.private_dns_zone_id
    node_resource_group               = local.node_resource_group
    private_cluster_enabled           = var.private_cluster_enabled
    enable_azure_policy               = var.enable_azure_policy
    enable_pod_security_policy        = var.enable_pod_security_policy
    api_server_authorized_ip_ranges   = var.api_server_authorized_ip_ranges
    kubernetes_version                = var.kubernetes_version
    http_application_routing_enabled  = var.http_application_routing_enabled
    kube_dashboard_enabled            = var.kube_dashboard_enabled
    role_based_access_control_enabled = var.role_based_access_control_enabled
    log_analytics_workspace_id        = var.log_analytics_workspace_id
    tags                              = var.tags
    identity_type                     = var.identity_type
    user_assigned_identity_id         = var.user_assigned_identity_id
    client_id                         = var.client_id
    client_secret                     = var.client_secret
    linux_admin_user_name             = var.linux_admin_user_name
    linux_admin_ssh                   = var.linux_admin_ssh
    windows_admin_user_name           = var.windows_admin_user_name
    windows_admin_user_password       = var.windows_admin_user_password
    network_profile                   = var.network_profile
    # default_node_pool                 = local.default_node_pool
    default_node_pool                 = var.default_node_pool
    attach_repository                 = var.attach_repository
    # node_pool_subnet_id               = var.node_pool_subnet_id
    vnet_subnet_id                    = var.vnet_subnet_id
    aks_vm_size                         = var.aks_vm_size
    # ad_auth                           = "true"
    # admin_group_object_ids             = module.azuread_group.admin_id
    # client_id                         = var.kubernetes_client_id
    # client_secret                     = var.kubernetes_client_secret
}
