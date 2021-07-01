# angular/variables

variable "hosted_zone" {}

variable "force_destroy" {
  default = false
}

variable "region" {
  default = "us-east-1"
}

  region           = "${var.region}"
  s3_origin_id     = "${var.bucket}"