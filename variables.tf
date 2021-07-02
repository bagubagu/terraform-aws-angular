# angular/variables

variable "hosted_zone" {}

variable "force_destroy" {
  default = false
}

variable "region" {
  default = "us-east-1"
}

variable "deploy_policy_arn" {
}