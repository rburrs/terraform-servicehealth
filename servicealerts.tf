data "azurerm_subscriptions" "available" {  
}
resource "azurerm_resource_group" "alertsgroup" {
  name     = "alerts-rg"
  location = var.rgloc
}

resource "azurerm_monitor_action_group" "main" {
  name                = "securityalertgroup"
  resource_group_name = azurerm_resource_group.alertsgroup.name
  short_name          = "secgroup"

  email_receiver {
    name          = "richardburrs"
    email_address = "richardburrs@microsoft.com"
  }
}

resource "azurerm_monitor_activity_log_alert" "main" {
  // for_each = var.subscriptions

  name                = "securityalerts"
  resource_group_name = azurerm_resource_group.alertsgroup.name
  // scopes              = each.key
  scopes      = toset([for s in data.azurerm_subscriptions.available.subscriptions.*.id : "/subscriptions/${s}"])
  description = "This alert will monitor security related service health events."

  criteria {
    category = "ServiceHealth"


    service_health {
      locations = var.loc
      events    = var.events
      services  = var.services
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}