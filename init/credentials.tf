variable "secret" {}

resource "azurerm_key_vault_secret" "tfstate" {
    name = "tfstate-access-key"
    value = azurerm_storage_account.storage.primary_access_key
    key_vault_id = azurerm_key_vault.kv.id
    provider = azurerm.sub
}

resource "azurerm_key_vault_secret" "user" {
    name = join("", [local.config.env,"-",local.config.project,"-","deploy","-","admin"])
    value = local.user
    key_vault_id = azurerm_key_vault.kv.id
    provider = azurerm.sub
}

resource "azurerm_key_vault_secret" "pwd" {
    name = join("", [local.config.env,"-",local.config.project,"-","deploy","-","admin","-","pwd"])
    value = local.pwd
    key_vault_id = azurerm_key_vault.kv.id
    provider = azurerm.sub
}

resource "azurerm_key_vault_secret" "sp" {
    name = local.config.sp_name
    value = var.secret
    key_vault_id = azurerm_key_vault.kv.id
    provider = azurerm.sub
}
