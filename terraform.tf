provider "heroku" {
  email = "${var.heroku_email}"
  api_key = "${var.heroku_api_key}"
}

resource "heroku_app" "default" {
  name = "${var.heroku_app_name}"
  region = "${var.heroku_app_region}"

  config_vars = {
    APP_DEBUG = "${var.app_debug}"
  }

  buildpacks = [
    "heroku/ruby"
  ]
}
