# Install Prometheus Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/prometheus-community/prometheus)\
[Chart Values Link](https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/values.yaml)

### Add Namespace

```bash
kubectl create namespace monitoring
```

### Persistent Volume

add Persistent Volume for the monitoring storage

- Apply the pv/pvc manifest files

```bash
kubectl apply -f prometheus-persistent-volume-nfs.yaml
kubectl --namespace monitoring apply -f prometheus-persistent-volume-claim.yaml
```

- Test the `persistent-volume`

```bash
kubectl get pv
kubectl describe pv prometheus-persistent-volume-nfs

kubectl get pvc
kubectl --namespace monitoring describe pvc prometheus-persistent-volume-claim-nfs
```

- Remove pv/pvc

```bash
kubectl --namespace monitoring delete pvc prometheus-persistent-volume-claim-nfs
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
helm --namespace monitoring install prometheus prometheus-community/prometheus -f values.yaml
```

### Port Forwarding

```bash
kubectl port-forward --namespace monitoring --address 0.0.0.0 $(kubectl get pods --namespace monitoring --selector "app.kubernetes.io/name=prometheus" --output=name) 9090:9090
```

## Remove the Chart

```bash
helm --namespace monitoring uninstall prometheus
kubectl --namespace monitoring delete pvc prometheus-persistent-volume-claim-nfs
kubectl delete pv prometheus-persistent-volume-nfs
```

## Notes
