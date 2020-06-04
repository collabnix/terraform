provider "google" {
  version = "~> 3.0.0"
  project = var.gcp_project_id
  region  = var.gcp_project_location
}
