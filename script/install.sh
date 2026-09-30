#!/usr/bin/env bash

# Supported Parameters:
#   $1 = uninstall

minikube() {
    printf "Starting Minikube Function\n\n"
    if command -v minikube > /dev/null; then
        echo "minikube already installed"
    else
        echo "minikube is not installed, installing now"
        curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
        sudo install minikube-linux-amd64 /usr/local/bin/minikube
        rm minikube-linux-amd64
    fi
}

kubectl() {
    printf "Starting Kubectl Function\n\n"
    if command -v kubectl > /dev/null; then
        echo "kubectl already installed"
    else
        echo "kubectl is not installed, installing now"
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        chmod +x kubectl
        mkdir -p ~/.local/bin
        mv ./kubectl ~/.local/bin/kubectl
    fi

}

helm() {
    printf "Starting Helm Function\n\n"
    if command -v helm > /dev/null; then
        echo "helm already installed"
    else
        echo "helm is not installed, installing now"
        curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
        chmod 700 get_helm.sh
        ./get_helm.sh
    fi

}

docker() {
    printf "Starting Docker Function\n\n"
    if command -v docker > /dev/null; then
        echo "Docker already installed"
    else
        echo "Docker is not installed, installing now"
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
        sudo apt update
        sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    fi

}

git() {
    printf "Starting Git Function\n\n"
    if command -v git > /dev/null; then
        echo "Git already installed"
    else
        echo "Git is not installed, installing now\n"
        sudo apt update
        sudo apt install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
    fi
}

command_libraries() {
    printf "Starting Command libraries Function\n\n"
    if command -v curl > /dev/null; then
        echo "Command libraries already installed"
    else
        echo "Command libraries are not installed, installing now\n"
        sudo apt update
        sudo apt install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
    fi
}

start_minikube() {
    read -t 5 -p "Start Minikube (y/n): " input
    if [[ "$input" = "y" ]]; then
        echo "Starting Minikube."
        minikube start
        minikube tunnel
    else
        echo "User chose not to start Minikube."
    fi
}

install() {
    printf "Running Installation script\n"
    command_libraries
    minikube
    kubectl
    helm
    docker
    git
    start_minikube
    exit 0
}

uninstall() {
    printf "Running Uninstallation script\n"
    sudo apt remove minikube kubectl helm docker git
    exit 0
}

if [ -z "$1" ]; then
    if [ "$1" == "install" ]; then
        echo "installing..."
        install
    elif [ "$1" == "uninstall" ]; then
        echo "uninstalling..."
        uninstall
    else
        echo "Unknown argument Exiting."
        exit 1
    fi
fi
