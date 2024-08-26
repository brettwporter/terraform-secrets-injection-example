#! /bin/bash

# This script sets a secret in AWS Secrets Manager
#
# It does the following:
#
# 1. Applies the Terraform code to create a new secret if it doesn't exist
# 2. Grab the current secret value
# 3. Update the secret with the new or modified value
#
# Example:
# ./set-secret name=my-app stage=dev secret_name=my_secret_name secret_value=my_secret_value

NAME=$1
STAGE=$2
SECRET_NAME=$3
SECRET_VALUE=$4

if [ -z "$SECRET_NAME" ] || [ -z "$SECRET_VALUE" ]; then
    echo "Error: Both 'name' and 'value' parameters are required."
    echo "Usage: $0 <name> <stage> <secret_name> <secret_value>"
    exit 1
fi

echo "Setting secret: $SECRET_NAME"
cd infra
terraform init
terraform apply -auto-approve -var="name=$NAME" -var="stage=$STAGE" -target="aws_secretsmanager_secret.this"

CURRENT_SECRET=$(aws secretsmanager get-secret-value --secret-id $(terraform output -json secret_name | jq -r .) --query SecretString --output text)

if [ -n "$CURRENT_SECRET" ]; then
    UPDATED_SECRET=$(echo $CURRENT_SECRET | jq --arg key "$SECRET_NAME" --arg value "$SECRET_VALUE" '. + {($key): $value}')
else
    UPDATED_SECRET=$(echo "{\"$SECRET_NAME\":\"$SECRET_VALUE\"}" | jq .)
fi

# Update the secret with the new or modified value
aws secretsmanager put-secret-value --secret-id $(terraform output -json secret_name | jq -r .) --secret-string "$UPDATED_SECRET"