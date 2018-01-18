# C100 Heroku Hosting

[Terraform][terraform] project to create the production environment for the [C100 Family Justice application][c100-app] in [Heroku]:[heroku].

[terraform]: https://www.terraform.io/
[c100-app]: https://github.com/ministryofjustice/c100-application
[heroku]: https://heroku.com

## Setup

To use this project, you need a Heroku API key. You can get this from the MoJ Digital Heroku account(credentials available from Rattic).

    cp dotenv.example .env

Edit `.env` and update the environment variables, then;

    source .env
    make build

This will create the application on Heroku.
