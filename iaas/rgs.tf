/* Create RG
------------------------------------------------------------------*/
resource "azurerm_resource_group" "system-rg" {
    name = join("", [local.config.env,"-",local.config.group,"-",local.config.project,"-","System","-","rg"])
    location = "canadaCentral"
    provider = azurerm.sub
    tags = local.config.tags
}

resource "azurerm_resource_group" "network-rg" {
    name = join("", [local.config.env,"-",local.config.group,"-",local.config.project,"-","Network","-","rg"])
    location = "canadaCentral"
    provider = azurerm.sub
    tags = local.config.tags
}