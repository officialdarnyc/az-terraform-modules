module "workload" {
  source          = "../../../../wrapper/workload"
  client_id       = var.client_id
  environment     = var.environment
  purpose         = var.purpose
  client_name     = var.client_name
  location        = var.location
  subscription_id = var.subscription_id

  resource_name_prefix = var.resource_name_prefix
  resource_group_name  = var.resource_group_name

  virtual_network_name          = var.virtual_network_name
  virtual_network_address_space = var.virtual_network_address_space
  subnets                       = var.subnets

  public_ips = var.public_ips

  bastion_hosts = var.bastion_hosts

  user_managed_identity_name          = var.user_managed_identity_name
  app_gateway_name                    = var.app_gateway_name
  sku                                 = var.sku
  gateway_ip_configuration            = var.gateway_ip_configuration
  backend_address_pool                = var.backend_address_pool
  frontend_port                       = var.frontend_port
  backend_http_settings               = var.backend_http_settings
  probe                               = var.probe
  frontend_ip_configuration           = var.frontend_ip_configuration
  http_listener                       = var.http_listener
  url_path_map                        = var.url_path_map
  request_routing_rule                = var.request_routing_rule
  app_gateway_frontend_ip_config_pip  = var.app_gateway_frontend_ip_config_pip
  app_gateway_ip_configuration_vnet   = var.app_gateway_ip_configuration_vnet
  app_gateway_ip_configuration_subnet = var.app_gateway_ip_configuration_subnet
  tags                                = var.tags

  firewall_policyname = var.firewall_policyname
  firewall_policy_sku = var.firewall_policy_sku
  firewall_name       = var.firewall_name
  firewall_sku_name   = var.firewall_sku_name
  sku_tier            = var.sku_tier
  fw_ip_config_name   = var.fw_ip_config_name
  fw_ip_config_vnet   = var.fw_ip_config_vnet
  fw_ip_config_subnet = var.fw_ip_config_subnet
  fw_ip_config_pip    = var.fw_ip_config_pip

  network_peerings = var.network_peerings

  route_table_name = var.route_table_name
  routes           = var.routes

  firewall_policy_rule_name     = var.firewall_policy_rule_name
  firewall_policy_rule_priority = var.firewall_policy_rule_priority
  application_rule_collection   = var.application_rule_collection
  network_rule_collection       = var.network_rule_collection
  nat_rule_collection           = var.nat_rule_collection

  front_door_name     = var.front_door_name
  default_policy_name = var.default_policy_name
  routing_rules       = var.routing_rules
  waf_policies        = var.waf_policies
  aks_cluster_name    = var.aks_cluster_name
  repository_name     = var.repository_name
  client_secret       = var.client_secret
  kubernetes_version  = var.kubernetes_version
}