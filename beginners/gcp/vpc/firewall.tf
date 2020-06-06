resource "google_compute_firewall" "default" {
  name    = "firewall-vpc-network"
  network = google_compute_network.this.self_link

  allow {
    protocol = "tcp"
    ports    = var.ingress_ports
  }

  target_tags = ["http-server", "https-server"]
}