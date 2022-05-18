terraform {
  required_providers {
    azurerm = {
      version = "=2.78.0"
    }
  }
}

provider "azurerm" {
  features {}
}
