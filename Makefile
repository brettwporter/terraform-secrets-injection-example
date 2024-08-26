DEFAULT_STAGE=$$(whoami)
NAME=per-stack-secrets-example

.PHONY: default
default: help

.PHONY: help
help:
	@echo "Usage: make <target>"
	@echo
	@echo "Targets:"
	@echo "  dev - Grabs remote secrets and runs the website locally"
	@echo "  set-secret name=<secret_name> value=<secret_value> - Sets a secret value"
	@echo "  deploy [stage=<username>] - Deploy the infrastructure (default stage: current username)"
	@echo "  destroy - Destroys the infrastructure"
	@echo "  help - Display this help message"

.PHONY: install
install:
	@./scripts/install.sh

.PHONY: set-secret
set-secret:
	@./scripts/set-secret.sh "$(NAME)" "$${stage:-$(DEFAULT_STAGE)}" "$(name)" "$(value)"

.PHONY: dev
dev:
	@./scripts/dev.sh "$(NAME)" "$${stage:-$(DEFAULT_STAGE)}"

.PHONY: destroy
destroy:
	@./scripts/destroy.sh "$(NAME)" "$${stage:-$(DEFAULT_STAGE)}"