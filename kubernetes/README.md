# Minikube

## Install Docker

Source: [URL](https://docs.docker.com/engine/install/ubuntu/)

### Add `apt` Repository

#### Add Docker's official GPG key

```bash
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```

#### Install `docker` Package

```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Install Minikube

Source: [URL](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download)

```bash
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64 -y
```

### Start Minikube (Tested with WSL2 Ubuntu 24.04 on Windows 11)

```bash
minikube start --driver=hyperv
```

- lans access to minikube
open Terminal and run the command, the access is open as long as the terminal window is open

```bash
minikube tunnel
```

### Install Kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl

```

- Make sure you have 'Kubernetes' install, use 'kubectl' command to test

```bash
kubectl --help
```

### install Helm command

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh
```

- Make sure you have 'Helm' installed, use 'helm' command to test

```bash
helm --help
```

### Setup Volume Persistent

[Persistent Manual](PERSISTENT.md)

- Deploy Postgres Using Helm, us the [README](./postgres/README.md) file for more information

## Note

append paths to $PATH

```bash
export PATH=$PATH:/path/to/directory
```
