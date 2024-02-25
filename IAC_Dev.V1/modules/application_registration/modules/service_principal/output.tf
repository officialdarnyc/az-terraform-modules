output "service_principal_id" {
    value = azuread_service_principal.service_principal.id
}

output "secret_id" {
    value = azuread_application_password.service_principal_secret.key_id
}

output "secret_value" {
    value = azuread_application_password.service_principal_secret.value
}
