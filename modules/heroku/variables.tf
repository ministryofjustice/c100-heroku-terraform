variable "email" {}
variable "api_key" {}

# TODO: For prod, this should be something else
variable "app_name" {
  default = "c100-tf-demo"
}

variable "app_region" {
  default = "eu"
}

variable "db_plan" {
  default = "heroku-postgresql:hobby-basic"
}
variable "scheduler_plan" {
  default = "heroku-scheduler:standard"
}

variable "app_debug" {
  default = "false"
}

variable "pipeline_name" {
  default = "c100-pipeline"
}
variable "pipeline_stage" {
  default = "staging"
}
variable "couple_app_to_pipeline" {
  default = "0"
}
