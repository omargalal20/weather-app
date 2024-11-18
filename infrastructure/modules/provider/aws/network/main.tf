locals {
  subnet_ips = {
    public_a  = "172.31.64.0/24"
    public_b  = "172.31.65.0/24"
    private_a = "172.31.66.0/24"
    private_b = "172.31.67.0/24"
  }
  cidr = "172.31.0.0/16"
}

data "aws_region" "current" {}

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "5.1.0"
  name            = "${var.namespace}-vpc"
  cidr            = local.cidr
  azs             = ["${data.aws_region.current.name}b", "${data.aws_region.current.name}c"]
  private_subnets = [local.subnet_ips.private_a, local.subnet_ips.private_b]
  public_subnets  = [local.subnet_ips.public_a, local.subnet_ips.public_b]

  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = true

  tags = {
    Name = "${var.namespace}-vpc"
  }
}
