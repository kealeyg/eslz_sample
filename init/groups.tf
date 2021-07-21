# The Project_Contributors and Readers azuread_group need to be created before this terraform init can be executed. 
/*
data "azuread_group" "Project_Contributors_group" {
  name = "${local.prefix}-${var.project}-Contributors"
}

data "azuread_group" "Project_Readers_group" {
  name = "${local.prefix}-${var.project}-Readers"
}
*/