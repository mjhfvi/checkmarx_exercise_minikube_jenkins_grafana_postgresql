# Install Postgres exporter Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/prometheus-community/prometheus-postgres-exporter)\
[Chart Values Link](https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus-postgres-exporter/values.yaml)

### Add Namespace

```bash
kubectl create namespace infrastructure
```

### Install the Chart

setup the configmap and secrets

```bash
kubectl --namespace infrastructure apply -f postgresql-secret.yaml
```

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm --namespace infrastructure install prometheus-postgres-exporter prometheus-community/prometheus-postgres-exporter -f values.yaml
```

## Remove the Chart

```bash
helm --namespace infrastructure uninstall prometheus-postgres-exporter
```

## Notes

