output "job_arn" {
  description = "Amazon Resource Name (ARN) of Glue Job."
  value       = aws_glue_job.this.arn
}

output "job_id" {
  description = "Job name."
  value       = aws_glue_job.this.id
}

output "job_role_arn" {
  description = "Amazon Resource Name (ARN) specifying the role."
  value       = length(var.role_arn) > 0 ? var.role_arn : join("", aws_iam_role.role.*.arn)
}

output "job_security_configuration_id" {
  description = "Glue security configuration name."
  value       = length(var.security_configuration) > 0 ? var.security_configuration : join("", aws_glue_security_configuration.sec_cfg.*.id)
}

output "job_log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group."
  value       = aws_cloudwatch_log_group.log_group.arn
}
