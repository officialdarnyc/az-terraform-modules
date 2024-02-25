output "application_id" {
    value = module.application.application_id
}

output "application_object_id" {
    value = module.application.object_id
}

output "service_principal_id" {
    value = module.service_principal.service_principal_id
}

output "client_secret_id" {
    value = module.service_principal.secret_id
}

output "client_secret_value" {
    value = module.service_principal.secret_value
}
