variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "mig_group" {
  type = string
}

variable "backend_port" {
  type    = number
  default = 80
}
