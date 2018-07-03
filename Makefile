# run `make (env) plan` etc
demo: aws-vars-from-env
	$(eval export TF_VAR_env=demo)
	$(eval export env_dir=demo)
	terraform workspace select demo
	@true

staging: aws-vars-from-env
	$(eval export TF_VAR_env=staging)
	$(eval export env_dir=staging)
	terraform workspace select staging
	@true

prod: aws-vars-from-env
	$(eval export TF_VAR_env=prod)
	$(eval export env_dir=prod)
	terraform workspace select prod
	@true

aws-vars-from-env:
	$(eval export TF_VAR_aws_access_key="${AWS_ACCESS_KEY_ID}")
	$(eval export TF_VAR_aws_secret_key="${AWS_SECRET_ACCESS_KEY}")
	$(eval export TF_VAR_aws_region="eu-west-1")

create-workspaces:
	terraform workspace new demo
	terraform workspace new staging
	terraform workspace new prod


init:
	$(if $(and ${TF_VAR_env}, ${env_dir}),,$(error Usage: make <env> <action> OR TF_VAR_env=<env> make dev <action>))
	terraform init -reconfigure -lock=false -backend-config="key=${TF_VAR_env}.terraform.tfstate"

plan: init
	terraform plan -lock=false -var-file=environments/${env_dir}/terraform.tfvars

apply: init
	terraform apply -lock=false -var-file=environments/${env_dir}/terraform.tfvars

destroy: init
	terraform destroy -lock=false  -var-file=environments/${env_dir}/terraform.tfvars | grep -v 'Still destroying...'


plan-aws: init
	terraform plan -lock=false -var-file=environments/${env_dir}/terraform.tfvars -target=module.aws_ses

apply-aws: init
	terraform apply -lock=false -var-file=environments/${env_dir}/terraform.tfvars -target=module.aws_ses

destroy-aws: init
	terraform destroy -lock=false  -var-file=environments/${env_dir}/terraform.tfvars -target=module.aws_ses | grep -v 'Still destroying...'

.PHONY := init plan apply destroy staging prod demo
