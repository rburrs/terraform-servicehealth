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
    name          = "<name of individual or team>"
    email_address = "<email address or distribution group>"
  }
}

resource "azurerm_monitor_activity_log_alert" "main" {
  name                = "securityalerts"
  resource_group_name = azurerm_resource_group.alertsgroup.name
  /*Scopes = var.subscriptions */
  scopes      = toset(data.azurerm_subscriptions.available.subscriptions[*].id)
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