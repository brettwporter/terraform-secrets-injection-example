#! /bin/bash

# This script destroys the infrastructure for a specific stage
#
# It does the following:
#
# 1. Changes to the infrastructure directory
# 2. Initializes Terraform
# 3. Destroys the infrastructure using Terraform
#
# Example:
# ./destroy.sh my-app-name production

NAME=$1
STAGE=$2

echo "Destroying the infrastructure: $STAGE"
cd infra
terraform init
terraform destroy -auto-approve -var="name=$NAME" -var="stage=$STAGE"