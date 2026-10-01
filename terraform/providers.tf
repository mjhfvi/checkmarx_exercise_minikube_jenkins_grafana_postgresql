terraform {
  required_version = "~> 1.16"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~> 3.0" # Use the latest stable v3 version
    }
  }
}
