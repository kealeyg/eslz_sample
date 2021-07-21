resource "azurerm_subnet" "snet" {
    count = length(local.config.snet)
    name     = join("", [local.config.env,"CNR","-",local.config.project,"-", "subnet", count.index,"-","snet"])
    provider = azurerm.sub
    address_prefixes = [element(local.config.snet, count.index)]
    resource_group_name = azurerm_resource_group.network-rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet_network_security_group_association" "snet-nsg-association" {
    count = length(local.config.snet)
    provider = azurerm.sub
    subnet_id = element(azurerm_subnet.snet.*.id, count.index)
    network_security_group_id = azurerm_network_security_group.nsg.id
}
