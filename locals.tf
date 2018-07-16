# angular/locals
# https://www.terraform.io/docs/enterprise/guides/recommended-practices/part1.html
# https://medium.com/@diogok/terraform-workspaces-and-locals-for-environment-separation-a5b88dd516f5

locals {
  region           = "us-east-1"
  s3_origin_id     = "myS3Origin"
  hosted_zone_dash = "${replace(var.hosted_zone, ".", "-")}"
  origin_bucket    = "${local.hosted_zone_dash}-origin"
  log_bucket       = "${local.hosted_zone_dash}-cloudfront-log"
}
