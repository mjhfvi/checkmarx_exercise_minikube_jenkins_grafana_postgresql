variable "grafana_url" {
  description = "grafana url"
  type        = string
  nullable    = false
}

variable "grafana_auth" {
  description = "grafana auth"
  type        = string
  sensitive   = true
  nullable    = false
}
