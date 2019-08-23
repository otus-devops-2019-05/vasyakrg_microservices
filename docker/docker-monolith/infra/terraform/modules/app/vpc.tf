resource "google_compute_firewall" "firewall" {
  name = "${var.env_name}-allow-docker-default"

  # name of net
  network = "default"

  allow {
    protocol = "tcp"
    ports    = "${var.allow_ports}"
  }

  source_ranges = "${var.access_range}"
  target_tags   = "${var.vpc_tags}"
}
