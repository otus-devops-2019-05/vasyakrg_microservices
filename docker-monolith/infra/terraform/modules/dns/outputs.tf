output "app_domain_name" {
  value = "${google_dns_record_set.app_record.*.name}"
}
