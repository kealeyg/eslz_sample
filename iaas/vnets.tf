/* Create vNet
------------------------------------------------------------------*/
resource "azurerm_virtual_network" "vnet" {
    name = join("", [local.config.env,"CNR","-",local.config.project,"-","vnet"])
    provider = azurerm.sub
    location = "canadaCentral"
    address_space = [local.config.vnet]
    dns_servers = ["10.150.17.12", "10.150.17.13"]
    resource_group_name = azurerm_resource_group.network-rg.name
    tags = local.config.tags
}
