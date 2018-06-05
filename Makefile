# run `make (env) plan` etc
demo:
	$(eval export TF_VAR_env=demo)
	$(eval export env_dir=demo)
	@true

staging:
	$(eval export TF_VAR_env=staging)
	$(eval export env_dir=staging)
	@true

prod:
	$(eval export TF_VAR_env=prod)
	$(eval export env_dir=prod)
	@true

init:
	$(if $(and ${TF_VAR_env}, ${env_dir}),,$(error Usage: make <env> <action> OR TF_VAR_env=<env> make dev <action>))
	terraform init -reconfigure -lock=false -backend-config="key=${TF_VAR_env}.terraform.tfstate"


plan: init
	terraform plan -lock=false -var-file=environments/${env_dir}/terraform.tfvars

apply: init
	terraform apply -lock=false -var-file=environments/${env_dir}/terraform.tfvars

destroy: init
	terraform destroy -lock=false  -var-file=environments/${env_dir}/terraform.tfvars | grep -v 'Still destroying...'


.PHONY := init plan apply destroy staging prod demo
