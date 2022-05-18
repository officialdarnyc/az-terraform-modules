module "storage_account"{
    source                   = "./modules/storage_account"
    storage_account_name     = var.storage_account_name
    resource_group_name      = var.resource_group_name
    location                 = var.location
    account_tier             = var.account_tier
    account_replication_type = var.account_replication_type
    tags                     = var.tags
    prevent_destroy          = local.prevent_destroy
}

module "container" {
    source                  = "./modules/container"
    for_each                = local.containers
    name                    = each.value.name
    storage_account_name    = var.storage_account_name
    container_access_type   = each.value.access_type
    prevent_destroy         = var.prevent_destroy ? true : false
    depends_on              = [
        module.storage_account
    ]
}

module "storage_share" {
    source                  = "./modules/storage_share"
    for_each                = local.file_shares
    storage_share_name      = each.value.name
    storage_account_name    = var.storage_account_name
    quota                   = each.value.quota
    prevent_destroy         = var.prevent_destroy ? true : false
    depends_on              = [
        module.storage_account
    ]
}

#module "directory" {
#    source               = "./modules/directory"
#    directory_name       = var.directory_name
#    storage_share_name   = var.storage_share_name
#    storage_account_name = var.storage_account_name
#}

module "storage_account_private_endpoint" {
    source              = "../private_link_service"
    count               = local.storage_account_private_link_enabled ? 1 : 0

    location            = var.location
    resource_group_name = var.resource_group_name
    
    endpoint_name       = local.storage_account_private_link_endpoint_name
    subnet_id           = local.storage_account_private_link_subnet_id
    service_connections = [
        {
            resource_id      = module.storage_account.id
            subresource_name = local.subresource_name
        }
    ]

    depends_on = [
        module.storage_account
    ]
}


