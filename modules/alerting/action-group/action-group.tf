resource "azurerm_monitor_action_group" "action_group" {
  for_each            = var.action_groups
  name                = each.key
  resource_group_name = local.rg
  short_name          = substr(each.key, 0, 3)

  dynamic "event_hub_receiver" {
    for_each = each.value.event_hub_receiver != null ? each.value.event_hub_receiver : {}
    content {
      name                = event_hub_receiver.key
      event_hub_name      = event_hub_receiver.value.event_hub_name
      event_hub_namespace = event_hub_receiver.value.event_hub_namespace
    }
  }

  dynamic "webhook_receiver" {
    for_each = each.value.webhook_receiver != null ? each.value.webhook_receiver : {}
    content {
      name        = webhook_receiver.key
      service_uri = webhook_receiver.value.service_uri
    }
  }

  dynamic "email_receiver" {
    for_each = each.value.email_receiver != null ? each.value.email_receiver : {}
    content {
      name          = email_receiver.key
      email_address = email_receiver.value.email_address
    }
  }
}