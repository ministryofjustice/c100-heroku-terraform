
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-west-1"
}
variable "ses_domain" {
  default = "dsd.io"
}
variable "ses_config_set_name" {
  default = "c100-ses-dsd-io-config-set"
}
variable "ses_sns_topic_name" {
  default = "c100-ses-dsd-io-sns-topic"
}
variable "event_destination_name" {
  default = "event-destination-sns-topic"
}
