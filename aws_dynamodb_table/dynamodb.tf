resource "aws_dynamodb_table" "table" {
  name         = "${var.service_name}.${var.table_name}"
  billing_mode = "${var.billing_mode}"
  hash_key     = "${var.hash_key}"

  attribute {
    name = "${var.hash_key}"
    type = "${var.hash_key_type}"
  }

  server_side_encryption {
    enabled = "${var.server_side_encryption}"
  }

  point_in_time_recovery {
    enabled = "${var.point_in_time_recovery}"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = "${local.tags}"
}