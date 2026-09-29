# Checkmarx Exercise

This is en homework project for Checkmarx devops engineer position
this project is using GitOps & Platform Engineering methodology

## Documents

see project objective in the `doc` Folder
[DevOps Interview Exercise](./doc/DevOps%20Interview%20Exercise.docx)

## User Environment

- Network NAS (nfs Storage)
- Windows 11
- WSL2\Ubuntu 24.04
- VScode
- Git
- Windows Terminal
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

```bash
pip install pre-commit --break-system-packages
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

### Install Tools

[Install Cluster Tools Manual](./kubernetes/README.md)

### Deploy Apps to Cluster

[Install PostgreSQL](./postgres/README.md)

## Troubleshooting Issues

[troubleshooting](./TROUBLESHOOTING.md)
