resource "google_compute_address" "static" {
  name = "external-ip-${random_id.top_level_resource_suffix.hex}"
}
