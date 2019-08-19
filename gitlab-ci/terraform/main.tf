terraform {
  # Версия terraform
  required_version = ">=0.11.7"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"

  # ID проекта
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source         = "modules/app"
  count_instance = "${var.count_instance}"
  env_name       = "stage"
  public_key     = "${var.public_key}"
  private_key    = "${var.private_key}"
  zone_instance  = "${var.zone_instance}"
  vpc_tags       = ["gitlab-runners"]
  default_user   = "${var.default_user}"
}
