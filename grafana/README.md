# Install Grafana Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/grafana-community/grafana)\
[Chart Values Link](https://github.com/grafana-community/helm-charts/blob/main/charts/grafana/values.yaml)

### Add Namespace

```bash
kubectl create namespace monitoring
```

## Persistent Volume is not necessary
<!--
### Persistent Volume

add Persistent Volume for the monitoring storage

- Apply the pv/pvc manifest files

```bash
kubectl apply -f grafana-persistent-volume-nfs.yaml
kubectl --namespace monitoring apply -f grafana-persistent-volume-claim.yaml
```

- Test the `persistent-volume`

```bash
kubectl get pv
kubectl describe pv grafana-persistent-volume-nfs

kubectl get pvc
kubectl --namespace monitoring describe pvc grafana-persistent-volume-claim-nfs
```

- Remove pv/pvc

```bash
kubectl --namespace monitoring delete pvc grafana-persistent-volume-claim-nfs
kubectl delete pv grafana-persistent-volume-nfs
```

### set the values

edit the `values.yaml` file, remove `securityContext`

```txt
  # securityContext:
  #   runAsUser: 65534
  #   runAsNonRoot: true
  #   runAsGroup: 65534
  #   fsGroup: 65534
``` -->

### Install the Chart

```bash
helm repo add grafana-community https://grafana-community.github.io/helm-charts
helm repo update
helm --namespace monitoring install grafana grafana-community/grafana -f values.yaml
```

### Add Internet Access

#### IngressRoute

```bash
kubectl apply -f ingressroute.yaml
kubectl delete -f ingressroute.yaml
```

#### Port Forwarding - Testing

```bash
kubectl port-forward --namespace monitoring --address 0.0.0.0 $(kubectl get pod --namespace monitoring --selector "app.kubernetes.io/instance=grafana" --output=name) 3000:3000
```

## Remove the Chart

```bash
helm --namespace monitoring uninstall grafana
kubectl --namespace monitoring delete pvc grafana
```

## Notes
