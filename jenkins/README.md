# Install Jenkins Using Helm Chart

## Using the Official Helm Chart

[Artifacthub.io Link](https://artifacthub.io/packages/helm/jenkinsci/jenkins)\
[Chart Values Link](https://github.com/jenkinsci/helm-charts/blob/main/charts/jenkins/values.yaml)

### Add Namespace

```bash
kubectl create namespace infrastructure
```

<!-- ### Persistent Volume

add Persistent Volume for the infrastructure storage

- Apply the pv/pvc manifest files

```bash
kubectl apply -f jenkins-persistent-volume-nfs.yaml
kubectl --namespace infrastructure apply -f jenkins-persistent-volume-claim.yaml
```

- Test the `persistent-volume`

```bash
kubectl get pv
kubectl describe pv jenkins-persistent-volume-nfs

kubectl get pvc
kubectl --namespace infrastructure describe pvc jenkins-persistent-volume-claim-nfs
```

- Remove pv/pvc

```bash
kubectl --namespace infrastructure delete pvc jenkins-persistent-volume-claim-nfs
kubectl delete pv jenkins-persistent-volume-nfs
``` -->

## Add Admin Secret

```bash
kubectl --namespace infrastructure apply -f jenkins-secret.yaml
```

### set the values

edit the `values.yaml` file, disable `usePodSecurityContext`

```txt
controller:
  usePodSecurityContext: false
persistence:
  enabled: false
admin:
  existingSecret: "jenkins-admin-credentials-secret"
```

### Install the Chart

```bash
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm --namespace infrastructure install jenkins jenkins/jenkins -f values.yaml
```

### Update Chart Values

```bash
helm --namespace infrastructure upgrade --reset-values jenkins jenkins/jenkins -f values.yaml
```

### Port Forwarding

```bash
kubectl port-forward --namespace infrastructure --address 0.0.0.0 $(kubectl get pod --namespace infrastructure --selector "app.kubernetes.io/instance=jenkins" --output=name) 8080:8080
```

## Remove the Chart

```bash
helm --namespace infrastructure uninstall jenkins
kubectl --namespace infrastructure delete pvc jenkins-persistent-volume-claim-nfs
kubectl delete pv jenkins-persistent-volume-nfs
```

## Notes

- when using the `jcasc` plugin i dont need to use `persistence`
