# spa/cloudfront_lambda

resource "aws_lambda_function" "origin_request" {
  function_name    = "${local.hosted_zone_dash}-origin-request"
  filename         = "${data.archive_file.origin_request.output_path}"
  source_code_hash = "${data.archive_file.origin_request.output_base64sha256}"
  role             = "${aws_iam_role.lambda_edge.arn}"
  runtime          = "nodejs8.10"
  handler          = "index.handler"
  memory_size      = 128
  timeout          = 3
  publish          = true
}

resource "aws_lambda_function" "origin_response" {
  function_name    = "${local.hosted_zone_dash}-origin-response"
  filename         = "${data.archive_file.origin_response.output_path}"
  source_code_hash = "${data.archive_file.origin_response.output_base64sha256}"
  role             = "${aws_iam_role.lambda_edge.arn}"
  runtime          = "nodejs8.10"
  handler          = "index.handler"
  memory_size      = 128
  timeout          = 3
  publish          = true
}

resource "aws_lambda_function" "viewer_response" {
  function_name    = "${local.hosted_zone_dash}-viewer-response"
  filename         = "${data.archive_file.viewer_response.output_path}"
  source_code_hash = "${data.archive_file.viewer_response.output_base64sha256}"
  role             = "${aws_iam_role.lambda_edge.arn}"
  runtime          = "nodejs8.10"
  handler          = "index.handler"
  memory_size      = 128
  timeout          = 3
  publish          = true
}

data "archive_file" "origin_request" {
  type        = "zip"
  source_dir  = "${path.module}/lambdas/lambda-origin-request/src"
  output_path = "${path.module}/lambdas/lambda-origin-request.zip"
}

data "archive_file" "origin_response" {
  type        = "zip"
  source_dir  = "${path.module}/lambdas/lambda-origin-response/src"
  output_path = "${path.module}/lambdas/lambda-origin-response.zip"
}

data "archive_file" "viewer_response" {
  type        = "zip"
  source_dir  = "${path.module}/lambdas/lambda-viewer-response/src"
  output_path = "${path.module}/lambdas/lambda-viewer-response.zip"
}

resource "aws_iam_role" "lambda_edge" {
  name               = "${local.hosted_zone_dash}-lambda-edge-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_basic.json}"
}

data "aws_iam_policy_document" "lambda_basic" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "basic" {
  role       = "${aws_iam_role.lambda_edge.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
