provider "heroku" {
  email = "${var.email}"
  api_key = "${var.api_key}"
}

resource "heroku_app" "this_app" {
  name = "${var.app_name}"
  region = "${var.app_region}"

  config_vars = {
    APP_DEBUG = "${var.app_debug}"
  }

  buildpacks = [
    "https://github.com/heroku/heroku-buildpack-apt",
    "heroku/ruby"
  ]
}

# Add-on SSL to application
resource "heroku_addon" "ssl" {
  app  = "${heroku_app.this_app.name}"
  plan = "ssl"
}

resource "heroku_addon" "database" {
  app  = "${heroku_app.this_app.name}"
  plan = "${var.db_plan}"
}
resource "heroku_addon" "scheduler" {
  app  = "${heroku_app.this_app.name}"
  plan = "${var.scheduler_plan}"
}


# Create a Heroku pipeline
resource "heroku_pipeline" "pipeline" {
  name = "${var.pipeline_name}"
}

# Couple this apps to a particular pipeline stage
resource "heroku_pipeline_coupling" "this_app" {
  app      = "${heroku_app.this_app.name}"
  pipeline = "${heroku_pipeline.pipeline.id}"
  stage    = "${var.pipeline_stage}"
  count    = "${var.couple_app_to_pipeline}"
}
