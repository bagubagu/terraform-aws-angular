# spa/hosting_and_cdnlog_buckets

resource "aws_s3_bucket" "origin" {
  region        = "${local.region}"
  bucket        = "${local.origin_bucket}"
  acl           = "private"
  force_destroy = "${var.force_destroy}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  versioning {
    enabled = true
  }

  # acceleration_status = "Enabled"
}

resource "aws_s3_bucket" "log" {
  region        = "${local.region}"
  bucket        = "${local.log_bucket}"
  acl           = "log-delivery-write"
  force_destroy = "${var.force_destroy}"
}

resource "aws_s3_bucket_policy" "origin" {
  bucket = "${aws_s3_bucket.origin.id}"
  policy = "${data.aws_iam_policy_document.origin.json}"
}

data "aws_iam_policy_document" "origin" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "${aws_s3_bucket.origin.arn}",
      "${aws_s3_bucket.origin.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin.iam_arn}"]
    }
  }
}
