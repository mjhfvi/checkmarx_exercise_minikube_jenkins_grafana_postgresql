# Install PostgreSQL Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/cloudpirates-postgres/postgres)\
[Chart Values Link](https://github.com/CloudPirates-io/helm-charts/blob/main/charts/postgres/values.yaml)

### Add Namespace

```bash
kubectl create namespace database
```

### Persistent Volume

add Persistent Volume for the database storage

edit the `postgres-persistent-volume-nfs.yaml` file

```bash
spec:
    nfs:
        path: /home/USER/.nfs/storage/postgresql
        server: SERVER_IP_ADDRESS
```

- Apply the pv/pvc manifest files

```bash
kubectl apply -f postgres-persistent-volume-nfs.yaml
kubectl --namespace database apply -f postgres-persistent-volume-claim.yaml
```

- Test the `persistent-volume`

```bash
kubectl get pv
kubectl describe pv postgres-persistent-volume-nfs

kubectl get pvc
kubectl --namespace database describe pvc postgresql-persistent-volume-claim-nfs
```

- Remove pv/pvc

```bash
kubectl --namespace database delete pvc postgresql-persistent-volume-claim-nfs
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

```bash
kubectl --namespace database apply -f postgresql-secret.yaml
kubectl --namespace database apply -f postgresql-configmap.yaml

helm --namespace database install postgresql oci://registry-1.docker.io/cloudpirates/postgres -f values.yaml
```

## Remove the Chart

```bash
helm --namespace database uninstall postgresql
kubectl --namespace database delete pvc postgresql-persistent-volume-claim-nfs
kubectl delete pv postgres-persistent-volume-nfs
```

## Notes
