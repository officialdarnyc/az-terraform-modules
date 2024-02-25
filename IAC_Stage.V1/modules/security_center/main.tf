module "log_analytics_workspace" {
  source                       = "../../modules/log_analytics_workspace"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  log_analytics_workspace_name = var.log_analytics_workspace_name
  tags                         = var.tags
}

module "security_center_workspace" {
  source       = "./modules/workspace"
  scope        = var.scope
  workspace_id = module.log_analytics_workspace.workspace_id
  depends_on = [
    module.log_analytics_workspace
  ]
}
module "security_center_subscription_pricing" {
  source        = "./modules/subscription_pricing"
  tier          = var.tier
  resource_type = var.resource_type
  depends_on = [
    module.log_analytics_workspace
  ]
}
module "security_center_contact" {
  source              = "./modules/contact"
  email               = var.email
  phone               = var.phone
  alert_notifications = var.alert_notifications
  alerts_to_admins    = var.alerts_to_admins
}
module "security_center_setting" {
  source         = "./modules/setting"
  setting_name   = var.setting_name
  enable_setting = var.enable_setting
}
module "security_center_auto_provisioning" {
  source                   = "./modules/auto_provisioning"
  enable_auto_provisioning = var.enable_auto_provisioning
}
