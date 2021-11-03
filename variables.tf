variable "loc" {
  description = "Default Azure region"
  }

variable "services" {
  type = list(string)
  description = "Services of service health events to monitor"
}

variable "events" {
  type = list(string)
  description = "type of events to monitor"
}
 