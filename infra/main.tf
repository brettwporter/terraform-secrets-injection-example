resource "random_id" "resource_suffix" {
  byte_length = 8
}

locals {
  name  = var.name
  stage = var.stage

  resource_name = "${local.name}-${local.stage}-${random_id.resource_suffix.hex}"
}

resource "aws_secretsmanager_secret" "this" {
  name = local.resource_name
}

# Commented this out as this is an example repo. In a real project,
# you would have your resources defined below. 
#
# module "this" {
#   source = "git::https://github.com/brettwporter/infra.git//nextjs/opennext?ref=main"

#   name = local.resource_name
# }
