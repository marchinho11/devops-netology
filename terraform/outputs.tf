#output "aws_account_id" {
#  value       = data.aws_caller_identity.current.account_id
#  description = "AWS account ID"
#}
#
#output "aws_user_id" {
#  value       = data.aws_caller_identity.current.user_id
#  description = "AWS user ID"
#}
#
#output "aws_region" {
#  value       = data.aws_region.current.name
#  description = "AWS регион, который используется в данный момент"
#}
#
#output "ec2_private_ip" {
#  value       = aws_instance.web.private_ip
#  description = "Приватный IP ec2 инстансы"
#}
#
#output "ec2_private_net_id" {
#  value       = aws_instance.web.subnet_id
#  description = "Идентификатор подсети в которой создан инстанс."
#}