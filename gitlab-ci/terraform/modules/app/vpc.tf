# resource "google_compute_firewall" "firewall_puma" {
#   name = "${var.env_name}-allow-puma-default"
#
#   # name of net
#   network = "default"
#
#   allow {
#     protocol = "tcp"
#     ports    = ["9292"]
#   }
#
#   source_ranges = ["0.0.0.0/0"]
#   target_tags   = "${var.vpc_tags}"
# }

