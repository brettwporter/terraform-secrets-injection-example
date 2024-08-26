#! /bin/bash

NAME=$1
STAGE=$2

echo "Destroying the infrastructure: $STAGE"
cd infra
terraform init
terraform destroy -auto-approve -var="name=$NAME" -var="stage=$STAGE"