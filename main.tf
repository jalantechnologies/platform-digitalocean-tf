terraform {
  cloud {
    organization = "jalantechnologies"
    workspaces {
      name = "platform-do-cluster-tf"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

provider "kubernetes" {
  host                   = module.digital_ocean.do_cluster_host
  token                  = module.digital_ocean.do_cluster_token
  client_certificate     = module.digital_ocean.do_cluster_client_certificate
  client_key             = module.digital_ocean.do_cluster_client_key
  cluster_ca_certificate = module.digital_ocean.do_cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = module.digital_ocean.do_cluster_host
    token                  = module.digital_ocean.do_cluster_token
    client_certificate     = module.digital_ocean.do_cluster_client_certificate
    client_key             = module.digital_ocean.do_cluster_client_key
    cluster_ca_certificate = module.digital_ocean.do_cluster_ca_certificate
  }
}

provider "kubectl" {
  host                   = module.digital_ocean.do_cluster_host
  token                  = module.digital_ocean.do_cluster_token
  client_certificate     = module.digital_ocean.do_cluster_client_certificate
  client_key             = module.digital_ocean.do_cluster_client_key
  cluster_ca_certificate = module.digital_ocean.do_cluster_ca_certificate
  load_config_file       = false
}

module "digital_ocean" {
  source             = "./modules/digital-ocean"
  do_cluster_name    = var.do_cluster_name
  do_alert_email     = var.do_alert_email
  do_cluster_version = var.do_cluster_version
}

module "kubernetes" {
  depends_on           = [module.digital_ocean]
  source               = "./modules/kubernetes"
  cluster_issuer_email = var.cluster_issuer_email
  cluster_issuer_name  = "letsencrypt-prod"
}

module "atlas_mongodb" {
  count  = var.atlas_enabled ? 1 : 0
  source = "./modules/mongodb-atlas"

  atlas_org_id                 = var.atlas_org_id
  atlas_project_name           = var.atlas_project_name
  atlas_cluster_name           = var.atlas_cluster_name
  atlas_provider_name          = var.atlas_provider_name
  atlas_backing_provider_name  = var.atlas_backing_provider_name
  atlas_region                 = var.atlas_region
  atlas_instance_size_name     = var.atlas_instance_size_name
  atlas_mongodb_major_version  = var.atlas_mongodb_major_version
  atlas_database_name          = var.atlas_database_name
  atlas_database_username      = var.atlas_database_username
  atlas_database_user_password = var.atlas_database_user_password
  atlas_access_list_cidrs      = var.atlas_access_list_cidrs
}
