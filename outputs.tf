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

output "lambda_origin_request_qualified_arn" {
  value = "${aws_lambda_function.origin_request.qualified_arn}"
}

output "lambda_origin_response_qualified_arn" {
  value = "${aws_lambda_function.origin_response.qualified_arn}"
}

output "lambda_viewer_response_qualified_arn" {
  value = "${aws_lambda_function.viewer_response.qualified_arn}"
}
