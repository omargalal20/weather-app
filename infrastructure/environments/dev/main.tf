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
