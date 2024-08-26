#! /bin/bash

NAME=$1
STAGE=$2

echo "Deploying to stage: $STAGE"
cd infra
terraform init
terraform apply -auto-approve -var="name=$NAME" -var="stage=$STAGE"