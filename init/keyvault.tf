resource "azurerm_key_vault" "kv" {
    name = join("", [local.config.env,"CSV","-",local.config.project,"-","kv"])
    location = "canadaCentral"
    resource_group_name = azurerm_resource_group.keyvault-rg.name
    enabled_for_disk_encryption = true
    provider = azurerm.sub
    tenant_id = data.azurerm_client_config.current.tenant_id
    purge_protection_enabled = false
    sku_name = "standard"
    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id
        key_permissions = [
            "Get",
            "List",
            "Update",
            "Create",
            "Import",
            "Delete",
            "Recover",
            "Backup",
            "Restore",
        ]
        secret_permissions = [
            "Get",
            "List",
            "Set",
            "Delete",
            "Recover",
            "Backup",
            "Restore",
            "Purge",
        ]
        certificate_permissions = [
            "Get",
            "List",
            "Update",
            "Create",
            "Import",
            "Delete",
            "Recover",
            "Backup",
            "Restore",
            "ManageContacts",
            "ManageIssuers",
            "GetIssuers",
            "ListIssuers",
            "SetIssuers",
            "DeleteIssuers",
        ]
    }
    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = local.config.kv_accessgroup_id #GcDc-RBAC-XXXXX-ESLZ-Contributor
        key_permissions = [
            "Get",
            "List",
            "Update",
            "Create",
            "Import",
            "Delete",
            "Recover",
            "Backup",
            "Restore",
        ]
        secret_permissions = [
            "Get",
            "List",
            "Set",
            "Delete",
            "Recover",
            "Backup",
            "Restore",
            "Purge",
        ]
        certificate_permissions = [
            "Get",
            "List",
            "Update",
            "Create",
            "Import",
            "Delete",
            "Recover",
            "Backup",
            "Restore",
            "ManageContacts",
            "ManageIssuers",
            "GetIssuers",
            "ListIssuers",
            "SetIssuers",
            "DeleteIssuers",
        ]
    }
    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = "2e997a6d-e2c5-4d74-b6ea-38795d3c9deb" # GcPc-RBAC-CTO-PLATFORM-Owner
        key_permissions = [
            "Get",
            "List",
            "Update",
            "Create",
            "Import",
            "Delete",
            "Recover",
            "Backup",
            "Restore",
        ]
        secret_permissions = [
            "Get",
            "List",
            "Set",
            "Delete",
            "Recover",
            "Backup",
            "Restore",
            "Purge",
        ]
        certificate_permissions = [
            "Get",
            "List",
            "Update",
            "Create",
            "Import",
            "Delete",
            "Recover",
            "Backup",
            "Restore",
            "ManageContacts",
            "ManageIssuers",
            "GetIssuers",
            "ListIssuers",
            "SetIssuers",
            "DeleteIssuers",
        ]
    }
    network_acls {
        default_action = "Allow"
        bypass         = "AzureServices"
    }
    tags = local.config.tags
}

