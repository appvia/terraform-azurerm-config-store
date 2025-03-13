terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "config_store" {
  source = "../.."

  resource_group_name   = var.resource_group_name
  name                  = var.name
  location              = var.location
  create_resource_group = var.create_resource_group
  tags                  = var.tags
  config_values         = var.config_values
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = module.config_store.storage_account_name
}

output "config_blob_urls" {
  description = "URLs for each config blob"
  value       = module.config_store.config_blob_urls
} 