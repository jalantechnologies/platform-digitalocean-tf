# Terraform - DigitalOcean

This project is a template for setting up Kubernetes cluster on DigitalOcean.

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

## MongoDB Atlas Automation

This template can optionally provision MongoDB Atlas resources through Terraform.

- Create Atlas project
- Create Atlas free/shared cluster (defaults to `M0`)
- Create application database user
- Create IP access list entries
- Output connection string for Doppler or app env vars

Set these variables and enable Atlas provisioning:

```hcl
atlas_enabled     = true
atlas_org_id      = "YOUR_ATLAS_ORG_ID"
atlas_public_key  = "YOUR_ATLAS_PUBLIC_KEY"
atlas_private_key = "YOUR_ATLAS_PRIVATE_KEY"
```

Optional defaults:

```hcl
atlas_project_name       = "platform-apps"
atlas_cluster_name       = "shared-free-cluster"
atlas_instance_size_name = "M0"
atlas_region             = "US_EAST_1"
atlas_access_list_cidrs  = ["0.0.0.0/0"]
```

Sensitive outputs:

- `atlas_connection_uri`
- `atlas_database_user_password`
