# Create resource group if specified
resource "azurerm_resource_group" "config_store" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Get the existing resource group if not creating one
data "azurerm_resource_group" "existing" {
  count = var.create_resource_group ? 0 : 1
  name  = var.resource_group_name
}

locals {
  resource_group_id = var.create_resource_group ? azurerm_resource_group.config_store[0].id : data.azurerm_resource_group.existing[0].id
  resource_group_location = var.create_resource_group ? azurerm_resource_group.config_store[0].location : data.azurerm_resource_group.existing[0].location

  # First normalize: lowercase and remove non-alphanumeric characters
  normalized_rg = lower(replace(var.resource_group_name, "/[^a-z0-9]/", ""))
  normalized_name = lower(replace(var.name, "/[^a-z0-9]/", ""))

  # Combined name with prefix from resource group (up to 16 chars) and suffix from name (up to 8 chars)
  # This keeps it under 24 characters total while preserving recognizable parts of both names
  rg_prefix = substr(local.normalized_rg, 0, min(16, length(local.normalized_rg)))
  name_suffix = substr(local.normalized_name, 0, min(8, length(local.normalized_name)))

  # Final storage account name
  storage_account_name = "${local.rg_prefix}${local.name_suffix}"
}

# Storage account for configuration
resource "azurerm_storage_account" "config_store" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = local.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  static_website {
    index_document = "index.html"
  }

  tags = var.tags
}

# Create configuration content as blobs
resource "azurerm_storage_blob" "config_content" {
  for_each = var.config_values

  name                   = "${each.key}.json"
  storage_account_name   = azurerm_storage_account.config_store.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "application/json"
  source_content         = jsonencode({
    noun_value      = each.value.noun_value
    adjective_value = each.value.adjective_value
  })
} 