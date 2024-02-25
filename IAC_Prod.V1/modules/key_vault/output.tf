output "id" {
    description = "Key vault Id"
    value       = module.key_vault.id
}

output "url" {
    description = "Key Vault URL"
    value       = module.key_vault.vault_uri
}
