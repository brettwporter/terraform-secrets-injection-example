# Terraform SST-Inspired Secrets Management Example

This repository demonstrates a simple example of utilizing Terraform and a process inspired by SST for managing secrets in a NextJS application. The setup allows you to:

1. Store secret values securely in AWS Secrets Manager
2. Inject these secrets into your local development environment
3. Deploy and manage infrastructure using Terraform

## Key Features

- Secure secret management using AWS Secrets Manager
- Local development with automatically injected secrets
- Infrastructure as Code using Terraform
- Makefile for easy command execution

## Workflow

Follow these steps to set up and run your application:

1. Set your secrets:

   ```
   make set-secret name=<secret_name> value=<secret_value>
   ```

   Repeat this step for each secret your application needs.

2. Start local development:

   ```
   make dev
   ```

   This command will:

   - Apply the Terraform configuration
   - Retrieve secrets from AWS Secrets Manager
   - Inject the secrets as environment variables
   - Run your NextJS app locally

3. Develop your application with the injected secrets available as environment variables.

4. When ready to deploy:

   ```
   make deploy
   ```

   This will deploy your infrastructure to AWS.

5. To tear down the infrastructure:
   ```
   make destroy
   ```

## Getting Started

1. Ensure you have Terraform, AWS CLI, and pnpm installed
2. Clone this repository
3. Run `make install` to install dependencies
4. Set up your AWS credentials
5. Run `make dev` to start the local development environment with injected secrets
6. Use `make deploy` to deploy the infrastructure to AWS

## Available Commands

- `make dev`: Start local development with injected secrets
- `make set-secret name=<secret_name> value=<secret_value>`: Set a secret value
- `make deploy [stage=<stage_name>]`: Deploy the infrastructure
- `make destroy`: Destroy the infrastructure
- `make help`: Display help information

## Note

This example is inspired by SST's approach to secret management but implemented using Terraform and commands within a Makefile. It provides a simplified way to manage secrets for developers while maintaining security best practices.
