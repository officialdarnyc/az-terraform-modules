module "private_endpoint" {
  source = "./modules/private_endpoint"

  name                = var.endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  service_connections = local.service_connections
}
