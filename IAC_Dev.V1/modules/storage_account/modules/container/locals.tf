locals {
    container_access_type = var.container_access_type == null ? "private" : var.container_access_type
}