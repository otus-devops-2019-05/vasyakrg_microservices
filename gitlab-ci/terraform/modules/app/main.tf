# resource "google_compute_address" "app_ip" {
#   name = "${var.env_name}-reddit-app-ip"
# }

data "google_compute_image" "image" {
  family  = "${var.app_disk_image_family}"
  project = "debian-cloud"
}

resource "google_compute_instance" "app" {
  count        = "${var.count_instance}"
  name         = "gitlab-runner-${count.index+1}"
  machine_type = "g1-small"
  zone         = "${var.zone_instance}"
  tags         = "${var.vpc_tags}"

  metadata {
    ssh-keys = "${var.default_user}:${var.public_key}"
  }

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.image.name}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      # nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  # connection {
  #   type  = "ssh"
  #   user  = "appuser"
  #   agent = false
  #   host  = "${self.network_interface.0.access_config.0.nat_ip}"
  #
  #   private_key = "${var.private_key}"
  # }

  provisioner "local-exec" {
    command = "echo ${self.network_interface.0.access_config.0.nat_ip} >> '../ansible/inventory'"
  }
  provisioner "local-exec" {
    when    = "destroy"
    command = "rm '../ansible/inventory'"
  }
}
