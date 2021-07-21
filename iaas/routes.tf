resource "azurerm_route_table" "rt" {
    name = join("", [local.config.env,"CNR","-",local.config.project,"-","rt"])
    provider = azurerm.sub
    resource_group_name = azurerm_resource_group.network-rg.name
    location = "canadaCentral"
    disable_bgp_route_propagation = false
    route {
        name = "toCoreFW-Dev-Internet-route"
        address_prefix = "0.0.0.0/0"
        next_hop_in_ip_address = cidrhost(local.config.core,1066)
        next_hop_type = "VirtualAppliance"
    }
    route {
        name = "toCoreFW-Dev-Core-route"
        address_prefix = local.config.core
        next_hop_in_ip_address = cidrhost(local.config.core,1066)
        next_hop_type = "VirtualAppliance"
    }
    route {
        name = "toCoreFW-Dev-Core2-route"
        address_prefix = local.config.tof5
        next_hop_in_ip_address = cidrhost(local.config.core,1066) 
        next_hop_type = "VirtualAppliance"
    }
    tags = local.config.tags
}

resource "azurerm_subnet_route_table_association" "snet-rt-association" {
    count = length(local.config.snet)
    provider = azurerm.sub
    subnet_id = element(azurerm_subnet.snet.*.id, count.index)
    route_table_id = azurerm_route_table.rt.id
}

