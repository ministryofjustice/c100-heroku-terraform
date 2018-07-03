# run `make (env) plan` etc
demo: aws-vars-from-env
	$(eval export TF_VAR_env=demo)
	$(eval export env_dir=demo)
	@true

staging: aws-vars-from-env
	$(eval export TF_VAR_env=staging)
	$(eval export env_dir=staging)
	@true

prod: aws-vars-from-env
	$(eval export TF_VAR_env=prod)
	$(eval export env_dir=prod)
	@true

aws-vars-from-env:
	$(eval export TF_VAR_aws_access_key="${AWS_ACCESS_KEY_ID}")
	$(eval export TF_VAR_aws_secret_key="${AWS_SECRET_ACCESS_KEY}")
	$(eval export TF_VAR_aws_region="eu-west-1")
	echo "TF_VAR_aws_access_key=${TF_VAR_aws_access_key}"
	echo "TF_VAR_aws_secret_key=${TF_VAR_aws_secret_key}"
	echo "TF_VAR_aws_region=${TF_VAR_aws_region}"


init:
	$(if $(and ${TF_VAR_env}, ${env_dir}),,$(error Usage: make <env> <action> OR TF_VAR_env=<env> make dev <action>))
	terraform init -reconfigure -lock=false -backend-config="key=${TF_VAR_env}.terraform.tfstate"

output: init
	terraform output  -module=aws_ses

plan: init
	terraform plan -lock=false -var-file=environments/${env_dir}/terraform.tfvars

apply: init
	terraform apply -lock=false -var-file=environments/${env_dir}/terraform.tfvars

destroy: init
	terraform destroy -lock=false  -var-file=environments/${env_dir}/terraform.tfvars | grep -v 'Still destroying...'


.PHONY := init plan apply destroy staging prod demo
