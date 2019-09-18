variable app_disk_image_family {
  description = "Disk image for reddit app"
  default     = "debian-9"
}

variable "zone_instance" {
  default = "europe-west1-b"
}

variable "count_instance" {
  description = "count of instances"
  default     = "1"
}

variable "public_key" {
  description = "public key used for ssh access"
  default     = ""
}

variable "private_key" {
  description = "private key used for ssh access"
  default     = ""
}

variable "install_app" {
  default = "true"
}

variable "db_internal_ip" {
  default = "127.0.0.1"
}

variable "vpc_tags" {
  type    = "list"
  default = []
}

variable "env_name" {
  default = ""
}

variable "default_user" {
  default = ""
}
