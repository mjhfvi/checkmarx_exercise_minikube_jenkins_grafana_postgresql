# Install Traefik Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/traefik/traefik)\
[Chart Values Link](https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml)

### Add Namespace

```bash
kubectl create namespace infrastructure
```

### set the values

edit the `values.yaml` file, set user name and password

```bash
ingressRoute:
  dashboard:
    enabled: true
log:
  # -- Alternative logging levels are TRACE, DEBUG, INFO, WARN, ERROR, FATAL, and PANIC.
  level: "INFO"  # @schema enum:[TRACE,DEBUG,INFO,WARN,ERROR,FATAL,PANIC]; default: "INFO"
```

### Install the Chart

```bash
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm --namespace infrastructure install traefik traefik/traefik -f values.yaml
```

- Update Chart Values

```bash
helm --namespace infrastructure upgrade --reset-values traefik traefik/traefik -f values.yaml
```

## Remove the Chart

```bash
helm --namespace infrastructure uninstall traefik
```

## Access Dashboard

### Port Forwarding - Only for Testing

```bash
kubectl port-forward --namespace infrastructure --address 0.0.0.0 $(kubectl get pod --namespace infrastructure --selector "app.kubernetes.io/instance=traefik-infrastructure" --output=name) 8080:8080
```

[dashboard](http://localhost:8080/dashboard/)

## Notes

if you manage local DNS server, make suke to add the domain url to the DNS server
you can add the url to the hosts file when testing locally