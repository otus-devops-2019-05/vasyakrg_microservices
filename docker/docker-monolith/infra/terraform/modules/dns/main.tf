data "google_dns_managed_zone" "zone" {
  name    = "${var.dns_zone_id_name}"
  project = "${var.dns_project}"
}

resource "google_dns_record_set" "app_record" {
  count   = "${var.count_records}"
  project = "${var.dns_project}"
  name    = "${var.prefix}${count.index + 1}.${var.dns_zone_name}."
  type    = "A"
  ttl     = 300

  managed_zone = "${data.google_dns_managed_zone.zone.id}"

  rrdatas = ["${element(var.list_ip,count.index)}"]
}
