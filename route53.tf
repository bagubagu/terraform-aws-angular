# spa/route53_apex_and_www

resource "aws_route53_record" "apex" {
  zone_id = "${data.aws_route53_zone.zone.id}"

  name = "${var.hosted_zone}"
  type = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.origin.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.origin.hosted_zone_id}"
    evaluate_target_health = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.zone.id}"

  name    = "www.${var.hosted_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_cloudfront_distribution.origin.domain_name}"]

  lifecycle {
    create_before_destroy = true
  }
}
