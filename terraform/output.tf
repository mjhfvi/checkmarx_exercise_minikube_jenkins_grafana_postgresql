output "org_name" {
  description = "Name of Org"
  value       = try(grafana_organization.my_org.name, null)
}

output "dashboard_id" {
  description = "ID of Dashboard"
  value       = try(grafana_dashboard.postgresql_dashboard.dashboard_id, null)
}
