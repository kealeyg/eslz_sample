
/* Outputs
------------------------------------------------------------------*/
output "init_outputs" {
    value = {
      storageAccount = azurerm_storage_account.storage.name
      accessKey = azurerm_storage_account.storage.primary_access_key
      containerName = azurerm_storage_container.container.name
      user = local.user
      pwd = local.pwd
    }
}