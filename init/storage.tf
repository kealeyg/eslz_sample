resource "azurerm_storage_account" "storage" {
  name = lower(join("", [local.config.env, local.config.project, substr(sha1(azurerm_resource_group.storage-rg.id), 0, 3), "stg"]))
  provider = azurerm.sub
  resource_group_name = azurerm_resource_group.storage-rg.name
  location = "canadaCentral"
  account_kind = "BlobStorage"
  account_tier = "Standard"
  access_tier = "Hot"
  account_replication_type = "RAGRS"
  tags = local.config.tags
}

resource "azurerm_storage_container" "container" {
  name = "tfstate"
  provider = azurerm.sub
  storage_account_name = azurerm_storage_account.storage.name
  container_access_type = "private"
}
