locals {
    config = {
        sp_name = "GcDc-Terragrunt-DCSB-sp"
        sp_keyvault = "GcDcCSV-PS-kv" # Use GcPcCSV-Platform2-kv on first deploy
        subscription_id = "fa16d1b3-c809-4145-a0e2-fe5c303e7007" 
        kv_accessgroup_id = "4c9a67a4-f7a8-4e37-9390-be1f739f590d" # GcDc-RBAC-DCSB_PS-ESLZ-Reader
        env = "GcDc"
        group = "DCSB"
        project = "PS"
        user = "admps"
        pwd = "DCSBCanada1!"
        vnet = "10.150.196.0/24"
        tof5 = "100.96.184.0/21"
        snet = ["10.150.196.0/26"]
        core =  "10.150.0.0/20"
        tags = {
            env = "dev"
            classification = "pbmm"
            owner = "example@domain.ca"
            contact = "example@domain.ca"
            deployment = "azure-bca-iac-2021-05-17"
            project = "DCSB-PS"
        }
    }
    sp_app = try(jsondecode(run_cmd("--terragrunt-quiet", "powershell","$(az ad sp list --output json --display-name ${local.config.sp_name})"))[0])
    sp_secret = try(run_cmd("--terragrunt-quiet", "powershell","$(az keyvault secret show --name ${local.config.sp_name} --vault-name ${local.config.sp_keyvault} --query value -o tsv)"))
}
inputs = {
    config = local.config
    secret = local.sp_secret
}
terraform {
    extra_arguments "environment" {
        commands = ["apply","plan","destroy"]
        env_vars = {
            ARM_TENANT_ID="${local.sp_app.appOwnerTenantId}"
            ARM_CLIENT_ID="${local.sp_app.appId}"
            ARM_CLIENT_SECRET="${local.sp_secret}"
        }
    }
}
generate "main" {
    path = "main.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
    /* Provider
    ------------------------------------------------------------------*/
    provider "azurerm" {
        alias = "sub"
        features {}
        subscription_id = "${local.config.subscription_id}"
    }
    data "azurerm_client_config" "current" {
        provider = azurerm.sub
    }
    /* Variables
    --------------------------------------------------------------------*/
    variable "config" {}
    EOF
}