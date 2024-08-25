locals {
  name  = var.general_config.name
  stage = var.general_config.stage

  resource_name = "${local.name}-${local.stage}"
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
