#! /bin/bash

# This script installs dependencies for the project
#
# It does the following:
#
# 1. Installs Homebrew packages: Terraform, AWS CLI, pnpm, and Node.js
# 2. Installs pnpm dependencies for the project
#
# Example:
# ./install.sh

echo "Installing dependencies"
brew tap hashicorp/tap
brew update
brew install hashicorp/tap/terraform awscli@2.17.37 pnpm@9.9.0 node@22.7.0

echo "Installing pnpm dependencies"
pnpm install