# Install Postgres exporter Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/runix/pgadmin4)\
[Chart Values Link](https://github.com/rowanruseler/helm-charts/blob/main/charts/pgadmin4/values.yaml)

### Add Namespace

```bash
kubectl create namespace infrastructure
```

### Install the Chart

setup the configmap and secrets

```bash
kubectl --namespace infrastructure apply -f pgadmin-credentials.yaml
```

```bash
helm repo add runix https://helm.runix.net/
helm repo update

helm --namespace infrastructure install pgadmin4 runix/pgadmin4 -f values.yaml
```

## Remove the Chart

```bash
helm --namespace infrastructure uninstall pgadmin4
```

## Notes

  email: chart@domain.com
  password: SuperSecret
  server: postgresql.infrastructure.svc.cluster.local
  port: 5432
  user: postgres
  password: "Check postgresql Secret"