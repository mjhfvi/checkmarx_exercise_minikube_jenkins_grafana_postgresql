# Install PostgreSQL Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/cloudpirates-postgres/postgres)\
[Chart Values Link](https://github.com/CloudPirates-io/helm-charts/blob/main/charts/postgres/values.yaml)

### Add Namespace

```bash
kubectl create namespace infrastructure
```

### Persistent Volume

add Persistent Volume for the infrastructure storage

edit the `postgres-persistent-volume-nfs.yaml` file

```bash
spec:
    nfs:
        path: /path/on/server/jenkins
        server: SERVER_IP_ADDRESS
```

- Apply the pv/pvc manifest files

```bash
kubectl apply -f postgres-persistent-volume-nfs.yaml
kubectl --namespace infrastructure apply -f postgres-persistent-volume-claim.yaml
```

- Test the `persistent-volume`

```bash
kubectl get pv
kubectl describe pv postgres-persistent-volume-nfs

kubectl get pvc
kubectl --namespace infrastructure describe pvc postgresql-persistent-volume-claim-nfs
```

- Remove pv/pvc

```bash
kubectl --namespace infrastructure delete pvc postgresql-persistent-volume-claim-nfs
kubectl delete pv postgres-persistent-volume-nfs
```

### set the values

edit the `postgresql-secret.yaml` file, set user name and password

```bash
data:
    POSTGRES_USER: ""
    POSTGRES_PASSWORD: ""
```

### Install the Chart

setup the configmap and secrets

```bash
kubectl --namespace infrastructure apply -f postgresql-secret.yaml
kubectl --namespace infrastructure apply -f postgresql-configmap.yaml
```

apply the chart

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm --namespace infrastructure install postgresql groundhog2k/postgres -f values.yaml
```

## Remove the Chart

```bash
helm --namespace infrastructure uninstall postgresql
kubectl --namespace infrastructure delete pvc postgresql-persistent-volume-claim-nfs
kubectl delete pv postgres-persistent-volume-nfs
helm repo remove postgresql
```

## Tools

[Metrics Exporter](./exporter/README.md)\
[PGAdmin](./pgadmin/README.md)

## Notes
