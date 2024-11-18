locals {
  namespace = "${var.project_name}-${var.env_name}"
}

module "network" {
  source       = "../../modules/provider/aws/network"
  region       = var.region
  project_name = var.project_name
  env_name     = var.env_name
  namespace    = local.namespace
}

module "ecr" {
  for_each     = toset(["${var.project_name}-backend-repo", "${var.project_name}-frontend-repo"])
  source       = "../../modules/provider/aws/ecr"
  vpc          = module.network.vpc
  project_name = var.project_name
  env_name     = var.env_name
  namespace    = local.namespace
  name         = each.key
}

module "iam" {
  source       = "../../modules/provider/aws/iam"
  project_name = var.project_name
  env_name     = var.env_name
  namespace    = local.namespace
}

module "application_load_balancer" {
  source       = "../../modules/provider/aws/application-load-balancer"
  vpc          = module.network.vpc
  region       = var.region
  project_name = var.project_name
  env_name     = var.env_name
  namespace    = local.namespace
}


module "server" {
  source                  = "../../modules/provider/aws/server"
  vpc                     = module.network.vpc
  region                  = var.region
  project_name            = var.project_name
  env_name                = var.env_name
  namespace               = local.namespace
  instance_type           = "t3.small"
  key_name                = "${local.namespace}-server-key-pair"
  key_pair_file_path      = var.EC2_KEY_PAIR_PATH
  iam_role_name           = module.iam.server_iam_role_name
  aws_lb_target_group_arn = module.application_load_balancer.aws_lb_target_group_arn
}
