module "azure_firewall_policy" {
    source = "./modules/azure_firewall_policy"

    resource_group_name         = var.resource_group_name
    location                    = var.location
    firewall_policyname         = var.firewall_policyname
    firewall_policy_sku         = var.firewall_policy_sku
}

module "azure_firewall" {
    source = "./modules/azure_firewall"

    resource_group_name         = var.resource_group_name
    location                    = var.location
    firewall_name               = var.firewall_name
    firewall_sku_name           = var.firewall_sku_name
    sku_tier                    = var.sku_tier
    firewall_policy_id          = module.azure_firewall_policy.id
    fw_ip_config_name           = var.fw_ip_config_name
    fw_ip_config_subnet_id      = var.fw_ip_config_subnet_id 
    fw_ip_config_pipid          = var.fw_ip_config_pipid 

    depends_on = [
      module.azure_firewall_policy
    ]
}

module "azure_firewall_policy_rule_collection_group"{
    source = "./modules/azure_firewall_policy_rule_collection_group"

    resource_group_name         = var.resource_group_name
    location                    = var.location
    firewall_policy_rule_name       = var.firewall_policy_rule_name
    firewall_policy_rule_priority   = var.firewall_policy_rule_priority
    application_rule_collection = var.application_rule_collection
    network_rule_collection         = var.network_rule_collection
    nat_rule_collection             = var.nat_rule_collection
    firewall_policy_id                    = module.azure_firewall_policy.id

    depends_on = [
      module.azure_firewall
    ]
}