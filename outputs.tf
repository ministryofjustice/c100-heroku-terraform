output "sns_topic_name" {
  value = "${module.aws_ses.sns_topic_name}"
}
output "ses_config_set_name" {
  value = "${module.aws_ses.ses_config_set_name}"
}
