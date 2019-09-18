variable project {
  description = "Project ID"
}

variable "dns_project" {
  default = ""
}

variable region {
  description = "Region"
  default     = "us-west1"
}

variable "zone_instance" {
  default = "us-west1-b"
}

variable "env_name" {
  default = "stage"
}

variable "count_instance" {
  description = "count of instances"
  default     = "1"
}

variable "app_disk_image_family" {
  description = "Disk image"
  default     = "docker-app"
}

variable "disk_size" {
  default = "10"
}

variable "access_range" {
  type        = "list"
  description = "Access range list"
  default     = ["0.0.0.0/0"]
}

variable "vpc_tags" {
  type    = "list"
  default = ["stage-reddit-docker-app"]
}

variable "default_user" {
  default = "appuser"
}

variable "dns_zone_name" {
  default = "aits.life"
}

variable "dns_zone_id_name" {
  default = "env-dns"
}

variable "prefix" {
  default = "docker"
}
