variable "project_id" {
  description = "05004 Project id"
  type        = string
  default     = "lab-dev-421508"
}

variable "region" {
  description = "TW"
  type        = string
  default     = "asia-east1"
}

variable "zone" {
  description = "GCP Zone"
  default     = "asia-east1-a"
}

variable "db_instance_name" {
  default = "gcp-iac-mysql-demo"
}

variable "db_name" {
  default = "demo_app"
}

variable "db_user" {
  default = "demo_user"
}

variable "db_password" {
  default = "demo_password"
}

variable "root_password" {
  default = "root_password"
}

variable "instance_count" {
  default = 1
}

variable "bucket_name" {
  type    = string
  default = "gcp-iac-cdn-bucket-demo"
}
