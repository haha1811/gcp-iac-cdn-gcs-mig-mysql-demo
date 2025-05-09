resource "google_sql_database_instance" "default" {
  name             = var.instance_name
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"
  }

  root_password = var.root_password
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.default.name
  password = var.db_password
}

resource "google_sql_database" "app" {
  name     = var.db_name
  instance = google_sql_database_instance.default.name
}

output "connection_name" {
  value = google_sql_database_instance.default.connection_name
}

output "public_ip" {
  value = google_sql_database_instance.default.public_ip_address
}