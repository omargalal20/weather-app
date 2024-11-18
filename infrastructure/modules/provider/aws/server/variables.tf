variable "vpc" {
  type = any
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "env_name" {
  description = "The environment name of the project"
  type        = string
}

variable "namespace" {
  description = "The environment name of the project"
  type        = string
}

variable "instance_type" {
  description = "The instance type of the server"
  type        = string
}

variable "key_pair_file_path" {
  description = "The key pair file path of the server"
  type        = string
}

variable "key_name" {
  description = "The key name credentials of the server"
  type        = string
}

variable "iam_role_name" {
  description = "The iam role name of the instance of the server"
  type        = string
}

variable "aws_lb_target_group_arn" {
  description = "The arn of the application load balancer target group"
  type        = string
}
