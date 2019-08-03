variable "aws_region" {
  description = "the AWS region"
  default     = "eu-central-1"
}

variable "service_name" {
  description = "the name of the whole service"
}

variable "function_name" {
  description = "the name of the concrete lambda"
}

variable "description" {
  description = "description of the lambda"
  default     = ""
}

variable "environment" {
  description = "the environment variables"
  type        = "map"
  default     = {}
}

variable "filename" {
  description = "the dummy file with sourcecode for the lambda"
  default     = "dummy.zip"
}

variable "lambda_runtime" {
  description = "runtime of lambdas"
  default     = "nodejs10.x"
}

variable "lambda_handler" {
  description = "default lambda handler"
  default     = "index.default"
}

variable "timeout" {
  description = "lambda timeout"
  default     = 10
}

variable "memory_size" {
  description = "lambda memory size"
  default     = 1024
}

variable "with_extra_policy" {
  description = "defines if we need to create a extra policy with specific permissions"
  default     = false
}

variable "extra_policy" {
  description = "json output of aws_iam_policy_document"
  type        = "string"
  default     = ""
}

variable "tags" {
  description = "tags for all resources"
  type        = "map"
  default     = {}
}

locals {
  internal_tags = {
    module: "aws_lambda_function"
  }
  tags          = merge(var.tags, local.internal_tags)
  lambda        = {
    full_name = "${var.service_name}-${var.function_name}"
  }
}
