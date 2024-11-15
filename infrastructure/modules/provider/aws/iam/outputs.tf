
output "server_iam_role_name" {
  description = "IAM role name of the server instance"
  value       = aws_iam_role.server_iam_role.name
}
