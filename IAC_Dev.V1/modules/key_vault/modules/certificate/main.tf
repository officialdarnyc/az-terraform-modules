resource "azurerm_key_vault_certificate" "certificate" {
  name         = var.certificate_name
  key_vault_id = var.key_vault_id

  certificate {
    contents = filebase64(var.certificate_file_name)
    password = var.certificate_file_credentials
  }

  certificate_policy {
    issuer_parameters {
      name = var.issuer
    }

    key_properties {
      exportable = var.properties.exportable
      key_size   = var.properties.key_size
      key_type   = var.properties.key_type
      reuse_key  = var.properties.reuse_key
    }

    secret_properties {
      content_type = var.properties.content_type
    }
  }
}