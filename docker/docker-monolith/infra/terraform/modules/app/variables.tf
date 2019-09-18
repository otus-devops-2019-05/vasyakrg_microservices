variable app_disk_image_family {
  description = "Disk image for reddit app"
  default     = ""
}

variable "zone_instance" {
  default = "us-west1-b"
}

variable "count_instance" {
  description = "count of instances"
}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "disk_size" {
  default = "10"
}

variable public_key {
  description = "public key used for ssh access"
  default     = ""
}

variable private_key {
  description = "private key used for ssh access"
  default     = ""
}

variable "install_app" {
  default = "true"
}

variable "vpc_tags" {
  type    = "list"
  default = []
}

variable "access_range" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

variable "allow_ports" {
  default = []
}

variable "env_name" {
  default = ""
}

variable "default_user" {
  default = "appuser"
}
