output "vpc_name" {
  value = google_compute_network.this.name
}

output "subnet_name" {
  value = google_compute_subnetwork.this.name
}
