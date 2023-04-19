## This zone already exists since the base valha.la domain uses DNSSEC and the DS records need to be configured.
## The data block simulates TF having created this.

# resource "google_dns_managed_zone" "xyz-demo-zone" {
#   name        = "xyz-corp-zone"
#   dns_name    = "${var.domain}."
#   description = "Example DNS zone"
# }

data "google_dns_managed_zone" "liatrio-demo-zone" {
    name = "liatrio-demo"
}


resource "google_dns_record_set" "a" {
  name         = "xyz-app.${data.google_dns_managed_zone.liatrio-demo-zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.liatrio-demo-zone.name
  type         = "A"
  ttl          = 300

  rrdatas = [var.ingress_ip]
}
