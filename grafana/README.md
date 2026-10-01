# Install Grafana Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/grafana-community/grafana)\
[Chart Values Link](https://github.com/grafana-community/helm-charts/blob/main/charts/grafana/values.yaml)

### Add Namespace

```bash
kubectl create namespace infrastructure
```

## Persistent Volume is not necessary
<!--
### Persistent Volume

add Persistent Volume for the infrastructure storage

- Apply the pv/pvc manifest files

```bash
kubectl apply -f grafana-persistent-volume-nfs.yaml
kubectl --namespace infrastructure apply -f grafana-persistent-volume-claim.yaml
```

- Test the `persistent-volume`

```bash
kubectl get pv
kubectl describe pv grafana-persistent-volume-nfs

kubectl get pvc
kubectl --namespace infrastructure describe pvc grafana-persistent-volume-claim-nfs
```

- Remove pv/pvc

```bash
kubectl --namespace infrastructure delete pvc grafana-persistent-volume-claim-nfs
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

## Add Admin Secret

```bash
kubectl --namespace infrastructure apply -f grafana-secret.yaml
```

### Install the Chart

```bash
helm repo add grafana-community https://grafana-community.github.io/helm-charts
helm repo update
helm --namespace infrastructure install grafana grafana-community/grafana -f values.yaml
```

- Update Chart Values

```bash
helm --namespace infrastructure upgrade --reset-values grafana grafana-community/grafana -f values.yaml
```

### Add Internet Access

#### IngressRoute

```bash
kubectl apply -f ingress.yaml

kubectl replace -f ingress.yaml
kubectl delete -f ingress.yaml
```

#### Port Forwarding - Testing

```bash
kubectl port-forward --namespace infrastructure --address 0.0.0.0 $(kubectl get pod --namespace infrastructure --selector "app.kubernetes.io/instance=grafana" --output=name) 3000:3000
```

## Remove the Chart

```bash
helm --namespace infrastructure uninstall grafana
kubectl --namespace infrastructure delete pvc grafana
```

## Notes

Using Dashboard 24298 for this exercise
