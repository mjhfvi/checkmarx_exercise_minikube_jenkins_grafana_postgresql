provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}

resource "grafana_organization" "my_org" {
  name = "my_org"
}

resource "grafana_folder" "databases" {
  org_id = grafana_organization.my_org.org_id
  title  = "Test Folder"
}

resource "grafana_dashboard" "test_folder" {
  org_id = grafana_organization.my_org.org_id
  folder = grafana_folder.databases.id
  config_json = jsonencode({
    "title" : "My Dashboard Title",
    "uid" : "my-dashboard-uid"
    // ... other dashboard properties
  })
}

resource "grafana_dashboard" "postgresql_metrics" {
  config_json = jsonencode({
    id            = 24298
    uid           = "postgres-perf-dashboard"
    title         = "PostgreSQL Performance Metrics"
    tags          = ["postgres", "database", "infrastructure"]
    timezone      = "browser"
    schemaVersion = 36
    refresh       = "1m"
  })
}
