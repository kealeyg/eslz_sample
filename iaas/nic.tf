resource "azurerm_network_interface" "nic1" {
    name = join("", [local.config.env,"SWJ","-",local.config.project,"01","-","nic1"])
    provider = azurerm.sub
    location = "canadaCentral"
    resource_group_name   = azurerm_resource_group.system-rg.name
    enable_ip_forwarding = "false"
    enable_accelerated_networking = "false"   
    ip_configuration {
        name = join("", [local.config.env,"SWJ","-",local.config.project,"01","-","nic1","-","config1"])
        subnet_id = azurerm_subnet.snet[0].id
        private_ip_address = cidrhost(azurerm_subnet.snet[0].address_prefix,5)
        private_ip_address_allocation = "static"
        primary = "true"
    }
}
