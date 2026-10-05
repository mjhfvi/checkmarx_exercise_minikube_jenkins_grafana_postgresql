# Setup Telos OS

## Connect to Minikube

- set server ip address

```bash
export SERVER_IP 192.168.x.x
```

- build `config` file for kubectl

```bash
talosctl gen config minikube https://192.168.200.10:6443
talosctl kubeconfig -e 192.168.200.10 -n 192.168.200.10
talosctl apply-config --insecure -n 192.168.200.10 --file controlplane.yaml --talosconfig=./talosconfig
talosctl bootstrap --nodes 192.168.200.10 --endpoints 192.168.200.10 --talosconfig=./talosconfig
talosctl --nodes 192.168.200.10 --endpoints 192.168.200.10 --talosconfig=./talosconfig kubeconfig ./kubeconfig
cp ./kubeconfig ../.kube/config
```
