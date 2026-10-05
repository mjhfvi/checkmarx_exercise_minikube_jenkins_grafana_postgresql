# Terraform

## Create Grefana Access Token

use this online manual from grafana

[create access manual](https://grafana.com/docs/grafana-cloud/platform/security-and-account-management/security-and-access/authentication-and-permissions/access-policies/create-access-policies/)

add the token information to the `secret.tfvars` file
run terraform

```bash
terraform init
terraform plan -var-file="secret.tfvars" -out=plan-out
terraform apply "plan-out"

```

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.16 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | ~> 3.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 3.25.9 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [grafana_dashboard.postgresql_dashboard](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_organization.my_org](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/organization) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_grafana_auth"></a> [grafana\_auth](#input\_grafana\_auth) | grafana auth | `string` | n/a | yes |
| <a name="input_grafana_url"></a> [grafana\_url](#input\_grafana\_url) | grafana url | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dashboard_id"></a> [dashboard\_id](#output\_dashboard\_id) | ID of Dashboard |
| <a name="output_org_name"></a> [org\_name](#output\_org\_name) | Name of Org |
<!-- END_TF_DOCS -->
