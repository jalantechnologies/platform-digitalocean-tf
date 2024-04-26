# Terraform Plans

This project contains terraform plans for resources owned by Platform team.

## Steps

- Request access to organization's Terraform Cloud account
- Install Terraform CLI
- Login using your account - `terraform login`
- To plan - `terraform plan`
- To apply - `terraform apply`

## Issues

- DO's Kubernetes token expires from time to time. Helm will error out due to not reachable. Run this to refresh the
  token:

```bash
terraform refresh -target=module.digital_ocean.digitalocean_kubernetes_cluster.do_cluster
```
