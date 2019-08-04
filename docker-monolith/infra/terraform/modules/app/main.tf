data "google_compute_image" "image" {
  family = "${var.app_disk_image_family}"

  # project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "app" {
  count        = "${var.count_instance}"
  name         = "${var.env_name}-docker${count.index+1}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone_instance}"
  tags         = "${var.vpc_tags}"

  metadata {
    ssh-keys = "${var.default_user}:${var.public_key}"
  }

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.image.self_link}"
    }
  }

  network_interface {
    network = "default"

    access_config = {}
  }

  # connection {
  #   type  = "ssh"
  #   user  = "${var.default_user}"
  #   agent = false
  #   host  = "${self.network_interface.0.access_config.0.nat_ip}"
  #
  #   private_key = "${var.private_key}"
  # }
  #
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo groupadd docker",
  #     "sudo usermod -a -G docker ${var.default_user}",
  #   ]
  # }
}
