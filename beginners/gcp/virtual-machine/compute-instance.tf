# This resource will allow all the resources to have a particular prefix which will a user to 
# identify all the resources created by him.
resource "random_id" "top_level_resource_suffix" {
  byte_length = 8
}

resource "google_compute_instance" "nginx" {
  name         = "vm-${random_id.top_level_resource_suffix.hex}"
  machine_type = var.machine_type
  zone         = var.gcp_compute_zone

  allow_stopping_for_update = true

  boot_disk {
    source = google_compute_disk.default.self_link
  }

  # A startup script that will run on our os and setup a nginx server for us
  metadata_startup_script = "sudo apt-get update; sudo apt-get install nginx-light -y"

  # Allows traffic @ PORT 80. It is recommended to use custom vpc and subnets with firewalls rules
  tags = ["http-server"]

  # Block where you can configure your vpc and subnets
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  # Adding a service account
  service_account {
    scopes = ["https://www.googleapis.com/auth/monitoring"]
  }
}

