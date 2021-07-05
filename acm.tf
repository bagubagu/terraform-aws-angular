# spa/acm

data "aws_route53_zone" "zone" {
  name = "${var.hosted_zone}."
}

provider "aws" {
  region = "us-east-1"
  alias = "us-east-1"
}

resource "aws_acm_certificate" "cert" {
  provider = aws.us-east-1
  domain_name               = "*.${var.hosted_zone}"
  subject_alternative_names = ["${var.hosted_zone}"]
  validation_method         = "DNS"
  tags                      = {}
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = "${data.aws_route53_zone.zone.id}"
}

resource "aws_acm_certificate_validation" "cert" {
  provider = aws.us-east-1
  for_each = aws_route53_record.cert_validation
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation[each.key].fqdn}"]
}

output "cert_arn" {
  value = "${aws_acm_certificate.cert.arn}"
}
