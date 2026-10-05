# Checkmarx Exercise

This is en homework project for Checkmarx devops engineer position
this project is using GitOps & Platform Engineering methodology

## Documents

see project objective in the `doc` Folder
[DevOps Interview Exercise](./doc/DevOps%20Interview%20Exercise.docx)

## User Environment

- Network NAS (nfs Storage)
- Ubuntu 26.04 LTS
- VScode
- Git
- Lens K8S IDE

## Security

Using `pre-commit-config` to manage this project

<details>
  <summary>pre-commit Setup</summary>

list some of the tools

- shellcheck
- lint
- bandit
- secrets/gitleaks/talisman

Manual Install pip libraries

### Using APT

```bash
sudo apt install pre-commit
```
### Using pip

```bash
pip install pre-commit --break-system-packages
```

### Running pre-commit

```bash
pre-commit install
pre-commit autoupdate
pre-commit run --all-files --verbose
```

</details>

## Tools

- Minikube
- Docker
- Kubernetes
- Helm
- Terraform
- Git

## Prepare Environment

### Install Tools Script

- Build Minikube Script

[Install Script](./script/README.md)

### Deploy Applications to Cluster

- Setup Kubernetes

[Kubernetes](./kubernetes/README.md)\
[Volume Persistent](./Kubernetes/PERSISTENT.md)

- Deploy Applications

[Install PostgreSQL](./postgres/README.md)\
[Install Jenkins](./jenkins/README.md)\
[Install Prometheus](./prometheus/README.md)\
[Install Grafana](./grafana/README.md)
[Install Traefik](./traefik/README.md)

- Setup Infrastructure

[Terraform](./terraform/README.md)

## Troubleshooting Issues

[Troubleshooting](./TROUBLESHOOTING.md)
