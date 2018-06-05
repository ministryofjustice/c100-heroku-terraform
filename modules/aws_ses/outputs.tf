output "ses_config_set_name" {
  value = "${aws_ses_configuration_set.this_config_set.name}"
}

output "sns_topic_arn" {
  value = "${aws_sns_topic.email_notifications.arn}"
}
