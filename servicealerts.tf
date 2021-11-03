locals {
  subscription_ids = toset([
    "c4991cab-5087-4f7e-b84f-0b71c321997f",
    "063ee470-b444-4f3d-9819-cfda8b2ed411",
  ])
}
resource "azurerm_resource_group" "alertsgroup" {
  name     = "alerts-rg"
  location = var.loc
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
  for_each = local.subscription_ids

  name                = "securityalerts"
  resource_group_name = azurerm_resource_group.alertsgroup.name
  scopes              = each.key
  description         = "This alert will monitor a specific storage account updates."

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