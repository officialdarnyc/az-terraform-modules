module "log_analytics_workspace" {
    source                       = "./modules/log_analytics_workspace"
    resource_group_name          = var.resource_group_name
    location                     = var.location
    log_analytics_workspace_name = var.log_analytics_workspace_name
    tags                         = var.tags
}

module "log_analytics_solution" {
    source                 		 = "./modules/log_analytics_workspace_solution"
    for_each               		 = local.solutions
    resource_group_name    		 = var.resource_group_name
    location               		 = var.location
    solution_name          		 = each.value.name
    workspace_resource_id  		 = module.log_analytics_workspace.id
    workspace_name         		 = var.log_analytics_workspace_name
    tags                   		 = var.tags
    depends_on = [
        module.log_analytics_workspace
    ]
}

module "application_insights" {
    source                    	 = "./modules/application_insights"
    for_each                  	 = local.application_insights
    resource_group_name       	 = var.resource_group_name
    location                  	 = var.location
    application_insights_name 	 = each.value.name
    workspace_id             	 = module.log_analytics_workspace.id
    application_type         	 = var.application_type
    tags                    	 = var.tags
    depends_on = [
        module.log_analytics_workspace
    ]
}
