/* Create VMs
------------------------------------------------------------------*/
resource "azurerm_windows_virtual_machine" "vm01" {
    name = join("", [local.config.env,"SWJ","-",local.config.project,"01"])
    provider = azurerm.sub
    location = "canadaCentral"
    resource_group_name   = azurerm_resource_group.system-rg.name
    computer_name  = join("", [local.config.env,"SWJ","-",local.config.project,"01"])
    admin_username = var.user
    admin_password = var.pwd
    network_interface_ids = [azurerm_network_interface.nic1.id]
    size = "Standard_DS2_v2"
    enable_automatic_updates = "true"
    provision_vm_agent = "true"
    #encryption_at_host_enabled = "true"
    allow_extension_operations = "true"
    source_image_reference  {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2016-Datacenter"
        version = "latest"
    }
    /*
    source_image_reference  {
        publisher = "center-for-internet-security-inc"
        offer     = "cis-windows-server-2016-v1-0-0-l1"
        sku       = "cis-ws2016-l1"
        version   = "latest"
    }
    plan {
        name      = "cis-ws2016-l1"
        publisher = "center-for-internet-security-inc"
        product   = "cis-windows-server-2016-v1-0-0-l1"
    }
    */
    os_disk {
        name = join("", [local.config.env,"SWJ","-",local.config.project,"01","-","OSDisk1"])
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    tags = local.config.tags
}
resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown_vm01" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm01.id
  provider = azurerm.sub
  location = "canadaCentral"
  enabled = true
  daily_recurrence_time = "1700"
  timezone              = "Eastern Standard Time"
  notification_settings {
    enabled         = false
    time_in_minutes = "60"
  }
}
