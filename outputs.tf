# spa/outputs.tf
output "origin_bucket_id" {
  value = "${aws_s3_bucket.origin.id}"
}

output "origin_bucket_arn" {
  value = "${aws_s3_bucket.origin.arn}"
}

output "origin_bucket_hosted_zone_id" {
  value = "${aws_s3_bucket.origin.hosted_zone_id}"
}

output "origin_bucket_regional_domain_name" {
  value = "${aws_s3_bucket.origin.bucket_regional_domain_name}"
}

output "log_bucket_id" {
  value = "${aws_s3_bucket.log.id}"
}

output "cloudfront_distribution_domain_name" {
  value = "${aws_cloudfront_distribution.origin.domain_name}"
}

output "cloudfront_distribution_id" {
  value = "${aws_cloudfront_distribution.origin.id}"
}

output "cloudfront_distribution_arn" {
  value = "${aws_cloudfront_distribution.origin.arn}"
}
