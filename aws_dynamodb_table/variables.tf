variable "table_name" {
  description = "name of the dynamodb table"
}

variable "service_name" {
  description = "short name of the service using the dynamodb table"
}

variable "tags" {
  description = "tags for all resources"
  type        = "map"
  default     = {}
}

variable "point_in_time_recovery" {
  default     = false
  description = "enable point in time recovery backup feature"
}

variable "server_side_encryption" {
  default     = true
  description = "enable server side data encryption"
}

variable "hash_key" {
  default     = "id"
  description = "the hash key"
}

variable "hash_key_type" {
  default     = "S"
  description = "type of the hash key"
}

variable "billing_mode" {
  default     = "PAY_PER_REQUEST"
  description = "Billing mode for the Dynamodb table, can be PROVISIONED or PAY_PER_REQUEST"
}

locals {
  internal_tags = {
    module: "aws_lambda_function"
  }
  tags          = merge(var.tags, local.internal_tags)
}

