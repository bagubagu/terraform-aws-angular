# spa/hosting_and_cdnlog_buckets

resource "aws_s3_bucket" "origin" {
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
  bucket        = "${local.log_bucket}"
  acl           = "log-delivery-write"
  force_destroy = "${var.force_destroy}"
}

resource "aws_s3_bucket_policy" "origin" {
  bucket = "${aws_s3_bucket.origin.id}"
  policy = "${data.aws_iam_policy_document.origin.json}"
}

resource "aws_s3_bucket_policy" "deployment_policy" {
  bucket = "${aws_s3_bucket.origin.id}"
  policy = "${data.aws_iam_policy_document.deploy_policy.json}"
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

data "aws_iam_policy_document" "deploy_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:WriteObject",
      "s3:DeleteObject",
    ]

    resources = [
      "${aws_s3_bucket.origin.arn}",
      "${aws_s3_bucket.origin.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::672704314656:group/dev-deployment-group"]
    }
  }
}
