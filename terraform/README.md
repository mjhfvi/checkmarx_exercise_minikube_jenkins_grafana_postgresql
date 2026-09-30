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

``