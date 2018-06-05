

module "heroku" {
  source                  = "./modules/heroku"

  email                   = "${var.heroku_email}"
  api_key                 = "${var.heroku_api_key}"

  # TODO: For prod, this should be something else
  app_name                = "${var.heroku_app_name}"
  app_region              = "${var.heroku_app_region}"

  # TODO: This needs to be premium, so we get encryption at rest and high
  # availability
  db_plan                 = "${var.heroku_db_plan}"

  pipeline_name           = "${var.heroku_pipeline_name}"
  pipeline_stage          = "${var.heroku_pipeline_stage}"
  couple_app_to_pipeline  = "${var.heroku_couple_app_to_pipeline}"

}


module "aws_ses" {
  source                  = "./modules/aws_ses"

  # NOTE these variables will be read from ENV['AWS_ACCESS_KEY'] by TF
  # automatically
  access_key              = "${var.aws_access_key}"
  secret_key              = "${var.aws_secret_key}"
  region                  = "${var.aws_region}"

  ses_domain              = "${var.aws_ses_domain}"
  ses_sns_topic_name      = "${var.aws_ses_sns_topic_name}"
}
