/* Locals
------------------------------------------------------------------*/
locals {
    user = local.config.user == "" ? data.azurerm_key_vault_secret.user[0].value : local.config.user
    pwd = local.config.pwd == "" ? data.azurerm_key_vault_secret.pwd[0].value : local.config.pwd 
    config = jsondecode(var.config)
}

/* Data
------------------------------------------------------------------*/
data "azurerm_key_vault" "keyvault" {
    count = local.config.user == "" ? 1 : 0
    name = join("", [local.config.env,"CSV","-",local.config.project,"-","kv"])
    resource_group_name = join("", [local.config.env,"-",local.config.group,"-",local.config.project,"-","Keyvault","-","rg"])
    provider = azurerm.sub
}
data "azurerm_key_vault_secret" "user" {
    count = local.config.user == "" ? 1 : 0
    name = join("", [local.config.env,"-",local.config.project,"-","deploy","-","admin"])
    key_vault_id = data.azurerm_key_vault.keyvault[0].id
    provider = azurerm.sub
}
data "azurerm_key_vault_secret" "pwd" {
    count = local.config.pwd == "" ? 1 : 0
    name = join("", [local.config.env,"-",local.config.project,"-","deploy","-","admin","-","pwd"])
    key_vault_id = data.azurerm_key_vault.keyvault[0].id
    provider = azurerm.sub
}