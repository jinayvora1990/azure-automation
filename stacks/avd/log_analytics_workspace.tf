

resource "random_id" "this" {
  byte_length = 8
}

module "log_analytics" {
  # source = "github.com/equinor/terraform-azurerm-log-analytics"
  source = "../../modules/log_analytics_workspace"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}