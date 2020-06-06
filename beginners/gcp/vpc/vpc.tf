resource "google_compute_network" "this" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "this" {
  name                     = var.subnet_name
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.gcp_project_location
  network                  = google_compute_network.this.self_link
  private_ip_google_access = true
}
