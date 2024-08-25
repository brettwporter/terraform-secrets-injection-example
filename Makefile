DEFAULT_STAGE=$$(whoami)

.PHONY: default
default: help

.PHONY: help
help:
	@echo "Usage: make <target>"
	@echo
	@echo "Targets:"
	@echo "  dev - Grabs remote secrets and runs the website locally"
	@echo "  deploy [stage=<username>] - Deploy the infrastructure (default stage: current username)"
	@echo "  destroy - Destroys the infrastructure"
	@echo "  help - Display this help message"

.PHONY: install
install:
	@echo "Installing dependencies"
	pnpm install

.PHONY: dev
dev:
	@echo "Grabbing remote secrets"
	terraform apply -auto-approve -var="stage=$${stage:-$(DEFAULT_STAGE)}" -target="aws_secretsmanager_secret.this"
	@echo "Setting environment variables"
	$(eval SECRETS := $(shell aws secretsmanager get-secret-value --secret-id $$(terraform output -json secret_name | jq -r .) --query SecretString --output text | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]"))
	@echo "Running the website locally"
	env $(SECRETS) pnpm dev

.PHONY: deploy
deploy:
	@echo "Deploying to stage: $${stage:-$(DEFAULT_STAGE)}"
	terraform apply -auto-approve -var="stage=$${stage:-$(DEFAULT_STAGE)}"

.PHONY: destroy
destroy:
	@echo "Destroying the infrastructure: $${stage:-$(DEFAULT_STAGE)}"
	terraform destroy -auto-approve -var="stage=$${stage:-$(DEFAULT_STAGE)}"