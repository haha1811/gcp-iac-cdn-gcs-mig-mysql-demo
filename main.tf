##############################
# main.tf (root)
##############################

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "gcs" {
  source      = "./modules/gcs"
  project_id  = var.project_id
  bucket_name = var.bucket_name
}

module "cloud_sql" {
  source        = "./modules/cloud_sql"
  project_id    = var.project_id
  instance_name = var.db_instance_name
  db_name       = var.db_name
  db_user       = var.db_user
  db_password   = var.db_password
  region        = var.region
  root_password = var.root_password
}

module "mig" {
  source         = "./modules/mig"
  project_id     = var.project_id
  region         = var.region
  zone           = var.zone
  instance_count = var.instance_count
  instance_type  = "n1-standard-1"
  db_connection  = module.cloud_sql.connection_name
}

module "load_balancer" {
  source       = "./modules/load_balancer"
  project_id   = var.project_id
  region       = var.region
  bucket_name  = var.bucket_name
  mig_group    = module.mig.group_name
  backend_port = 80
}

output "gcs_url" {
  value = module.gcs.website_url
}

output "load_balancer_ip" {
  value = module.load_balancer.ip
}

output "sql_public_ip" {
  value = module.cloud_sql.public_ip
}
