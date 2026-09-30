provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}

resource "grafana_organization" "my_org" {
  name = "my_org"
}

## Use File in Local Folder
# resource "grafana_dashboard" "postgresql_dashboard" {
#   config_json = file("${path.module}/postgresql _monitoring_dashboard.json")
# }

## Use files From the `grafana/dashboards/ folder
resource "grafana_dashboard" "postgresql_dashboard" {
  # config_json = file("${path.module}/postgresql _monitoring_dashboard.json")
  config_json = file("../grafana/dashboards/postgresql _monitoring_dashboard.json")
}
