#! /bin/bash

# This script sets up and runs the development environment
#
# It does the following:
#
# 1. Retrieves remote secrets from AWS Secrets Manager
# 2. Applies Terraform configuration for the secrets
# 3. Fetches the secrets
# 4. Runs the website locally with the retrieved secrets as environment variables
#
# Example:
# ./dev.sh my-app-name development

NAME=$1
STAGE=$2

echo "Grabbing remote secrets"
cd infra
terraform init
terraform apply -auto-approve -var="name=$NAME" -var="stage=$STAGE" -target="aws_secretsmanager_secret.this"
terraform refresh -var="name=$NAME" -var="stage=$STAGE"

echo "Attempting to get secrets"
SECRETS=$(aws secretsmanager get-secret-value --secret-id $(terraform output -json secret_name | jq -r .) --query SecretString --output text)

echo "Running the website locally"
if [ -n "$SECRETS" ]; then
    if echo "$SECRETS" | jq empty > /dev/null 2>&1; then
        env $(echo "$SECRETS" | jq -r 'to_entries | map("\(.key)=\(.value)") | join(" ")') pnpm dev
    else
        echo "Invalid JSON found in secrets. Running without secrets."
        pnpm dev
    fi
else
    echo "No secrets found. Running without secrets."
    pnpm dev
fi