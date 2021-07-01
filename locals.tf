# angular/locals
# https://www.terraform.io/docs/enterprise/guides/recommended-practices/part1.html
# https://medium.com/@diogok/terraform-workspaces-and-locals-for-environment-separation-a5b88dd516f5

locals {
  region           = "${var.region}"
  hosted_zone_dash = "${replace(var.hosted_zone, ".", "-")}"
  origin_bucket    = "${local.hosted_zone_dash}-origin"
  s3_origin_id     = "${local.origin_bucket}"
  log_bucket       = "${local.hosted_zone_dash}-cloudfront-log"
}
