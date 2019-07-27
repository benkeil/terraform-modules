output "name" {
  value       = "${aws_dynamodb_table.table.name}"
  description = "Id (name) of the Resource"
}

output "arn" {
  value       = "${aws_dynamodb_table.table.arn}"
  description = "ARN of the Resource"
}

output "id" {
  value       = "${aws_dynamodb_table.table.id}"
  description = "Id (name) of the Resource"
}
