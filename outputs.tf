output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.config_store.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.config_store.name
}

output "primary_web_endpoint" {
  description = "The endpoint URL for the static website (primary)"
  value       = azurerm_storage_account.config_store.primary_web_endpoint
}

output "primary_web_host" {
  description = "The hostname for the static website (primary)"
  value       = azurerm_storage_account.config_store.primary_web_host
}

output "config_blob_urls" {
  description = "URLs for each config blob"
  value       = {
    for k, v in azurerm_storage_blob.config_content : k => "${azurerm_storage_account.config_store.primary_web_endpoint}${azurerm_storage_blob.config_content[k].name}"
  }
} 