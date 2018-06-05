# C100 Heroku Hosting

[Terraform][terraform] project to create environment-specific infrastructure for the [C100 Family Justice application][c100-app] in [Heroku]:[heroku] and AWS.

[terraform]: https://www.terraform.io/
[c100-app]: https://github.com/ministryofjustice/c100-application
[heroku]: https://heroku.com
[aws]: https://aws.amazon.com

## Setup

To use this project, you need a Heroku API key. You can get this from the MoJ Digital Heroku account(credentials available from Rattic). You'll also need your own AWS credentials (these should be under the mojdsd account - ask Cloud Platforms for yours if you don't know them already).

    cp dotenv.example .env

Edit `.env` and update the environment variables, then;

    source .env

## Running tasks

The code is parameterised, using an environment-specific config file (`environments/{env name}/terraform.tfvars`) to set appropriate values.

To run a task, you must provide an environment name, e.g.
```
# show intended plan of action on a particular environment (but don't actually do anything)
make demo plan
make staging plan
make prod plan

# actually make changes to an environment
make demo apply
make staging apply
make prod apply

# destroy an environment
make demo destroy
make staging destroy
make prod destroy
```

This will create your (empty) application on Heroku, and any required infrastructure on AWS.

If you have created your application in the shared MoJ Heroku account, you may need to add your personal account as a collaborator, so that you can deploy your code without having to log in using the main MoJ Heroku credentials.

## Manual steps

Unfortunately not everything we need is fully supported on Terraform yet - so there are still some manual steps you'll need to perform after setting up the foundations with `make (env) apply`

* Heroku pipeline Github integration (only available through the Heroku interface)
* Email subscription to the SNS topic (if you _want_ to get notifications for all email events, that is - if not, you dont' need to do anything else. If you _do_ want the notifications, you'll have to set them up in the AWS UI)

## Deploying the application code

* Set heroku environment variables
* Add a new git remote for the application
* `git push [your remote] master`
