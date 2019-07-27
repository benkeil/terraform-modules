# lambda
resource "aws_lambda_function" "lambda" {
  function_name = local.lambda.full_name
  description   = var.description
  role          = aws_iam_role.lambda.arn
  runtime       = var.lambda_runtime
  handler       = var.lambda_handler
  timeout       = var.timeout
  memory_size   = var.memory_size
  filename      = var.filename
  environment {
    variables = var.environment
  }
  depends_on    = [
    aws_iam_role_policy_attachment.lambda_basic,
    aws_cloudwatch_log_group.lambda,
  ]
  tags          = local.tags
}

# log_group
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${local.lambda.full_name}"
  retention_in_days = 7
}

# iam
data "aws_iam_policy_document" "lambda_basic" {
  statement {
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    actions   = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = local.lambda.full_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# iam - basic policy
resource "aws_iam_policy" "lambda_basic" {
  name   = "${local.lambda.full_name}.basic"
  path   = "/lambda/"
  policy = data.aws_iam_policy_document.lambda_basic.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_basic.arn
}

# iam - extra policy
resource "aws_iam_policy" "lambda_extra" {
  count  = var.with_extra_policy ? 1 : 0
  name   = "${local.lambda.full_name}.extra"
  path   = "/lambda/"
  policy = var.extra_policy
}

resource "aws_iam_role_policy_attachment" "lambda_extra" {
  count      = var.with_extra_policy ? 1 : 0
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_extra[count.index].arn
}
