/* Create RG
------------------------------------------------------------------*/
resource "azurerm_resource_group" "keyvault-rg" {
    name = join("", [local.config.env,"-",local.config.group,"-",local.config.project,"-","Keyvault","-","rg"])
    location = "canadaCentral"
    provider = azurerm.sub
    tags = local.config.tags
}
resource "azurerm_resource_group" "storage-rg" {
    name = join("", [local.config.env,"-",local.config.group,"-",local.config.project,"-","Storage","-","rg"])
    location = "canadaCentral"
    provider = azurerm.sub
    tags = local.config.tags
}


