# This disk will get attached to our VM.
resource "google_compute_disk" "default" {
  name     = "disk-${random_id.top_level_resource_suffix.hex}"
  type     = "pd-ssd"
  size     = 20
  zone     = var.gcp_compute_zone
  image    = data.google_compute_image.ubuntu_image.self_link
}

# This data source will get us the image name for Ubuntu.
data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-1604-lts"
  project = "ubuntu-os-cloud"
}
