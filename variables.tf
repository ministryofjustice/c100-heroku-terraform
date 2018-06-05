############################################
# HEROKU VARIABLES

variable "heroku_email" {}
variable "heroku_api_key" {}

# TODO: For prod, this should be something else
variable "heroku_app_name" {
  default = "c100-tf-demo"
}

variable "heroku_app_region" {
  default = "eu"
}

# TODO: This needs to be premium, so we get encryption at rest and high availability
variable "heroku_db_plan" {
  default = "heroku-postgresql:hobby-basic"
}

variable "heroku_app_debug" {
  default = "false"
}


variable "heroku_pipeline_name" {
  default = "c100-pipeline"
}
variable "heroku_pipeline_stage" {
  default = "staging"
}
variable "heroku_couple_app_to_pipeline" {
  default = "0"
}
############################################
