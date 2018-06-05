# Configure the AWS Provider
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


# use this config set name when sending email to get it to
# report events (bounce, delivery, etc) to the defined destination
resource "aws_ses_configuration_set" "this_config_set" {
  name = "${var.ses_config_set_name}"
}

# we need to make sure the topic exists
resource "aws_sns_topic" "email_notifications" {
  name = "${var.ses_sns_topic_name}"
}

resource "aws_ses_event_destination" "sns_topic" {
  name                   = "event-destination-sns-topic"
  configuration_set_name = "${aws_ses_configuration_set.this_config_set.name}"
  enabled                = true
  matching_types         = ["bounce", "send", "delivery", "reject", "complaint"]

  sns_destination = {
    topic_arn            = "${aws_sns_topic.email_notifications.arn}"
  }
}


# Subscription to an SNS topic with the email protocol
# is not yet supported in terraform, due to the verification process
# breaking the terraform model. For details, see:
# https://www.terraform.io/docs/providers/aws/r/sns_topic_subscription.html#email-json
