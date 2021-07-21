resource "azurerm_network_security_group" "nsg" {
    name = join("", [local.config.env,"CNR","-",local.config.project,"-","nsg"])
    provider = azurerm.sub
    location = "canadaCentral"
    resource_group_name = azurerm_resource_group.network-rg.name
    security_rule {
        name = "Allow_MAZ_JumpServer"
        priority = "100"
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_ranges = ["3389","22"]
        source_address_prefixes = [cidrhost(local.config.core, 10),cidrhost(local.config.core, 11),cidrhost(local.config.core, 12),cidrhost(local.config.core, 13)]
        destination_address_prefix = "*"
        description = "Allow_MAZ_JumpServer"
    }
    tags = local.config.tags
}
