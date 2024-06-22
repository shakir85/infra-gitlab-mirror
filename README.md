[![pipeline status](https://gitlab.com/homelabgroup/cicd/badges/main/pipeline.svg?ignore_skipped=true)](https://gitlab.com/homelabgroup/cicd/-/commits/main)

# Homelab Infrastructure

The Terraform and Ansible modules in this repo have been developed to run on a specific infrastructure. Therefore they most likely will not run out of the box on another environment without some modifications. But I hope they provide some ideas for anyone interested in automating their homelab resources.

## Resources

- [Proxmox as the virtualization environment](https://www.proxmox.com/en/) 
- [pfSense+](https://www.pfsense.org/) + used for local DNS
- [HA Proxy](https://www.haproxy.org) internal reverse proxy
- [My Terraform modules](https://github.com/shakir85/Terraform-Modules)
- Ansible as a config management, and Docker (on VMs) to host the [applications](https://gitlab.com/homelabgroup/apps)

I do not use the Proxmox console to create resources (VMs/LXCs). Everything is provisioned as code. I follow the [cattle-not-pets](https://cloudscaling.com/blog/cloud-computing/the-history-of-pets-vs-cattle/) analogy, which helped me reduce infrastructure maintenance time.


## Configuration

- Containers data are stored in NFS shares mounted in the VMs for storage decoupling which allow recycling containers without losing data.
- Apps are deployed using GitLab CI.
- GitLab Runners are provisioned on VMs and use tags to pick up jobs.
- VMs are bootstrapped to the Ansible controller to run maintenance tasks only.
- MacOS keychain via [security command](https://ss64.com/mac/security.html) for local secrets management.
- Datadog for logging and monitoring.

## Near future plans

- Selfhost the prod container images on Gitlab Container Registry, use tags and proper deployment process.
- ~~Add additional logging via Graylog~~ Done!.
- Add an additional monitoring service (uptime service).

## Future plans

- Migrate all containers to K8s.
- Deploy using ArgoCD.
- Use HashiCorp Vault for secrets management.
- Use MetalLB for ingress.
