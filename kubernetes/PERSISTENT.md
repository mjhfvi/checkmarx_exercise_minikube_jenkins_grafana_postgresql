# Volume Persistent Setup

## set the Storage Class Parameters

edit the `storageclass-nfs.yaml` file

- set the Server IP Address
- set the local Path for the Mount

```bash
parameters:
    server: SERVER_IP_ADDRESS
    path: /home/USER/.nfs/storage/
```

- Add Storage Class to Cluster

```bash
mkdir -p /home/USER/.nfs/storage/postgresql
kubectl apply -f ./storageclass-nfs.yaml
```

- Test the Storage Class

```bash
kubectl get storageclass
kubectl describe storageclass
```

- Delete Storage Class

```bash
kubectl delete storageclass storage-nfs
```
