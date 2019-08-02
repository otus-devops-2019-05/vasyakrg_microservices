terraform {
  required_version = ">=0.11.7"
}

provider "google" {
  version = "2.0.0"

  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source                = "./modules/app"
  env_name              = "${var.env_name}"
  count_instance        = "${var.count_instance}"
  public_key            = "${file("~/.ssh/id_rsa.pub")}"
  private_key           = "${file("~/.ssh/id_rsa")}"
  default_user          = "${var.default_user}"
  zone_instance         = "${var.zone_instance}"
  app_disk_image_family = "${var.app_disk_image_family}"
  vpc_tags              = "${var.vpc_tags}"
  access_range          = "${var.access_range}"
  allow_ports           = ["22", "9292"]

  install_app = "false"
}

module "dns" {
  source           = "./modules/dns"
  dns_project      = "${var.dns_project}"
  count_records    = "${var.count_instance}"
  list_ip          = ["${module.app.app_external_ip}"]
  dns_zone_id_name = "${var.dns_zone_id_name}"
  dns_zone_name    = "${var.dns_zone_name}"
  prefix           = "${var.prefix}"
}
