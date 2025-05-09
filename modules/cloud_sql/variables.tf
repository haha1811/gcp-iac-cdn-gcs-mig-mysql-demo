variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "instance_name" {
  description = "Cloud SQL instance name"
  type        = string
}

variable "region" {
  description = "GCP region for Cloud SQL"
  type        = string
}

variable "db_name" {
  description = "Name of the initial database"
  type        = string
}

variable "db_user" {
  description = "App-level database user"
  type        = string
}

variable "db_password" {
  description = "Password for the app-level user"
  type        = string
}

variable "root_password" {
  description = "Password for the root user"
  type        = string
}
