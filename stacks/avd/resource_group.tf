locals {
  tags = {
    project = "adcb"
    owners  = "jinay"
  }
}

module "resource_group" {
  source = "../../../modules/resource-groups"

  rg_name = var.rg_name
  tags    = local.tags
}