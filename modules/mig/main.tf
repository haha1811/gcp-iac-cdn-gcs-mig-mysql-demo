resource "google_compute_instance_template" "default" {
  name_prefix  = "mig-template"
  machine_type = var.instance_type
  region       = var.region

  tags = ["http-server"]

  metadata_startup_script = file("${path.module}/../../scripts/startup.sh")

  disk {
    boot         = true
    auto_delete  = true
    source_image = "projects/debian-cloud/global/images/family/debian-11"
  }

  network_interface {
    network       = "default"
    access_config {}
  }
}

resource "google_compute_instance_group_manager" "default" {
  name               = "app-mig"
  zone               = var.zone
  base_instance_name = "app-instance"
  version {
    instance_template = google_compute_instance_template.default.self_link
  }
  target_size = var.instance_count
}

output "group_name" {
  value = google_compute_instance_group_manager.default.instance_group
}
