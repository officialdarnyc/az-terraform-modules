resource "azurerm_application_insights" "appinsights" {
    name                       		  		= var.application_insights_name
    location                          		= var.location
    resource_group_name               		= var.resource_group_name
    workspace_id                      		= var.workspace_id
    application_type                  		= var.application_type
    daily_data_cap_in_gb					= var.daily_data_cap_in_gb
	daily_data_cap_notifications_disabled	= var.daily_data_cap_notifications_disabled
	retention_in_days						= var.retention_in_days
	sampling_percentage						= var.sampling_percentage
	disable_ip_masking						= var.disable_ip_masking
	local_authentication_disabled			= var.local_authentication_disabled
    tags    								= var.tags
}