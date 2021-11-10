variable "rgloc" {
  description = "location of resource group"
}
variable "loc" {
  description = "Azure regions to monitor"
}

variable "services" {
  type        = list(string)
  description = "Services of service health events to monitor"
}

variable "events" {
  type        = list(string)
  description = "type of events to monitor"
}
/* Use for testing on a subset of subscriptions.
variable "subscriptions" {
  type        = list(string)
  description = "subscriptions to monitor"
}
 */