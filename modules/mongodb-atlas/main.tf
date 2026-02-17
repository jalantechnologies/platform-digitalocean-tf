provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

resource "mongodbatlas_project" "this" {
  name   = var.atlas_project_name
  org_id = var.atlas_org_id
}

resource "mongodbatlas_cluster" "this" {
  project_id                  = mongodbatlas_project.this.id
  name                        = var.atlas_cluster_name
  cluster_type                = "REPLICASET"
  provider_name               = var.atlas_provider_name
  backing_provider_name       = var.atlas_backing_provider_name
  provider_region_name        = var.atlas_region
  provider_instance_size_name = var.atlas_instance_size_name
  mongodb_major_version       = var.atlas_mongodb_major_version
}

resource "random_password" "atlas_database_user_password" {
  count   = var.atlas_database_user_password == null ? 1 : 0
  length  = 32
  special = true
}

locals {
  effective_database_user_password = var.atlas_database_user_password != null ? var.atlas_database_user_password : random_password.atlas_database_user_password[0].result
}

resource "mongodbatlas_database_user" "app" {
  username           = var.atlas_database_username
  password           = local.effective_database_user_password
  project_id         = mongodbatlas_project.this.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = var.atlas_database_name
  }

  scopes {
    name = mongodbatlas_cluster.this.name
    type = "CLUSTER"
  }
}

resource "mongodbatlas_project_ip_access_list" "this" {
  for_each   = toset(var.atlas_access_list_cidrs)
  project_id = mongodbatlas_project.this.id
  cidr_block = each.value
  comment    = "Managed by Terraform"
}
