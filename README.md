# Terraform Secrets Management Example

This repository demonstrates a simple example of utilizing Terraform and a process
inspired by [SST](sst.dev) for managing secrets in an application without needing to
have them locally in an .env file for example. The setup allows you to:

1. Store secret values securely in AWS Secrets Manager
2. Inject these secrets into your local development environment
3. Deploy and manage infrastructure using Terraform

A `stage`, a.k.a environment, provided to the commands will determine where the Terraform
is deployed to. By default it is to a stage of your local machines username.

This approach can be expanded quite to do things such as run full cloud stacks per dev
with hot reloads on code changes.

## Key Features

- Secure secret management using AWS Secrets Manager
- Local development with automatically injected secrets
- Infrastructure as Code starter using Terraform
- Makefile for easy command execution

## Workflow

Follow these steps to set up and run your application:

1. Set your secrets:

   ```
   make set-secret name=<secret_name> value=<secret_value>
   ```

   This command will:

   - Apply the Terraform configuration for the secret
   - Add or update the secret provided

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

4. To tear down the infrastructure:
   ```
   make destroy
   ```

## Getting Started

1. Clone this repository
2. Run `make install` to install dependencies
3. Set up your AWS credentials
4. Run `make dev` to start the local development environment with injected secrets
5. Use `make deploy` to deploy the infrastructure to AWS

## Available Commands

- `make dev`: Start local development with injected secrets
- `make set-secret name=<secret_name> value=<secret_value>`: Set a secret value
- `make destroy`: Destroy the infrastructure
- `make help`: Display help information

## Note

This example is inspired by SST's approach to secret management but implemented using Terraform
and commands within a Makefile. It provides a simplified way to manage secrets for developers
while maintaining security best practices. SST's approach to a dev workflow is amazing and
recommend checking it out [here](sst.dev) if you're able to.
