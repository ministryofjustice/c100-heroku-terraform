

module "heroku" {
  source                  = "./modules/heroku"

  email                   = "${var.heroku_email}"
  api_key                 = "${var.heroku_api_key}"

  # TODO: For prod, this should be something else
  app_name                = "${var.heroku_app_name}"
  app_region              = "${var.heroku_app_region}"

  # TODO: This needs to be premium, so we get encryption at rest and high availability
  db_plan                 = "${var.heroku_db_plan}"

  pipeline_name           = "${var.heroku_pipeline_name}"
  pipeline_stage          = "${var.heroku_pipeline_stage}"
  couple_app_to_pipeline  = "${var.heroku_couple_app_to_pipeline}"

}
