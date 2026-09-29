# Troubleshooting Information

## Installing Tools

### Running `minikube start --force`

- ERROR: exit status 1: permission denied while trying to connect to the docker API at unix:///var/run/docker.sock
- Add your user to the 'docker' group: `sudo usermod -aG docker $USER && newgrp docker`

- ERROR: Enabling 'storage-provisioner' returned an error: running callbacks
- purge caches `minikube delete --all --purge`

- ERROR: access denied by server while mounting
- on TrueNAS Server enable `Allow non-root mount` for the NFS Service
