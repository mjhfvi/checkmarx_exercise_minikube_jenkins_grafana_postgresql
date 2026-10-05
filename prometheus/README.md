# Install Prometheus Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/prometheus-community/prometheus)\
[Chart Values Link](https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/values.yaml)

### Add Namespace

```bash
kubectl create namespace infrastructure
```

### Persistent Volume

add Persistent Volume for the infrastructure storage

edit the `prometheus-persistent-volume-nfs.yaml` file

```bash
spec:
    nfs:
        path: /path/on/server/prometheus
        server: SERVER_IP_ADDRESS
```

add Persistent Volume for the infrastructure storage

- Apply the pv/pvc manifest files

```bash
kubectl apply -f prometheus-persistent-volume-nfs.yaml
kubectl --namespace infrastructure apply -f prometheus-persistent-volume-claim.yaml
```

- Test the `persistent-volume`

```bash
kubectl get pv
kubectl describe pv prometheus-persistent-volume-nfs

kubectl get pvc
kubectl --namespace infrastructure describe pvc prometheus-persistent-volume-claim-nfs
```

- Remove pv/pvc

```bash
kubectl --namespace infrastructure delete pvc prometheus-persistent-volume-claim-nfs
kubectl delete pv prometheus-persistent-volume-nfs
```

### set the values

edit the `values.yaml` file, set user name and password

```txt
server:
  existingClaim: "prometheus-persistent-volume-claim-nfs"
  # securityContext:
  #   runAsUser: 65534
  #   runAsNonRoot: true
  #   runAsGroup: 65534
  #   fsGroup: 65534
```

### Install the Chart

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm --namespace infrastructure install prometheus prometheus-community/prometheus -f values.yaml
```

- Update Chart Values

```bash
helm --namespace infrastructure upgrade --reset-values prometheus prometheus-community/prometheus  -f values.yaml
```

### Port Forwarding - Only for Testing

- dont use this in production, grafana need the local dns in the cluster to communicat [kubernetes local url](https://prometheus-server.infrastructure.svc.cluster.local:80)


```bash
kubectl port-forward --namespace infrastructure --address 0.0.0.0 $(kubectl get pods --namespace infrastructure --selector "app.kubernetes.io/name=prometheus" --output=name) 9090:9090
```

## Remove the Chart

```bash
helm --namespace infrastructure uninstall prometheus
kubectl --namespace infrastructure delete pvc prometheus-persistent-volume-claim-nfs
kubectl delete pv prometheus-persistent-volume-nfs
```

## Notes
