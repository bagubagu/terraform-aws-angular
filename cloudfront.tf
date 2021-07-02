# spa/cloudfront

resource "aws_cloudfront_origin_access_identity" "origin" {
  comment = "${local.hosted_zone_dash}-origin"
}

resource "aws_cloudfront_distribution" "origin" {
  aliases             = ["${var.hosted_zone}", "www.${var.hosted_zone}"]
  comment             = "${local.hosted_zone_dash}-origin"
  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true

  origin {
    domain_name = "${aws_s3_bucket.origin.bucket_regional_domain_name}"
    origin_id   = "${local.s3_origin_id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin.cloudfront_access_identity_path}"
    }
  }

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.log.bucket_domain_name}"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = "${local.s3_origin_id}"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code    = 403
    response_code = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code    = 404
    response_code = 200
    response_page_path = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.cert.arn}"
    ssl_support_method  = "sni-only"

    # minimum_protocol_version = "TLSv1.1_2016"
  }
}
