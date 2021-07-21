include {path = find_in_parent_folders()}
remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        storage_account_name = "${dependency.init.outputs.init_outputs.storageAccount}"
        access_key = "${dependency.init.outputs.init_outputs.accessKey}"
        container_name = "tfstate"
    }
}
dependency "init" {
    config_path = "../init"
}
inputs = {
    user = dependency.init.outputs.init_outputs.user
    pwd = dependency.init.outputs.init_outputs.pwd
}
generate "terraform" {
    path = "terraform.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
    /* Backend
    ------------------------------------------------------------------*/
    terraform {
        backend "azurerm" {}
    }

    /* Locals
    ------------------------------------------------------------------*/
    locals {
        config = jsondecode(var.config)
    }
    
    variable "pwd" {}
    variable "user" {}

    EOF
}