resource "google_storage_bucket" "static_site" {
  name          = var.bucket_name
  location      = "ASIA"
  force_destroy = true
  uniform_bucket_level_access = true
  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_storage_bucket_iam_binding" "public" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"
  members = ["allUsers"]
}

output "website_url" {
  value = "http://storage.googleapis.com/${google_storage_bucket.static_site.name}/index.html"
}