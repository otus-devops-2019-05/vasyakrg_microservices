variable "dns_project" {
  default = ""
}

variable "dns_zone_id_name" {
  default = ""
}

variable "dns_zone_name" {
  default = ""
}

variable "prefix" {
  default = ""
}

variable "list_ip" {
  type    = "list"
  default = []
}

variable "count_records" {
  description = "count of record"
  default     = ""
}
