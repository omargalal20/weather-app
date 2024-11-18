variable "vpc" {
  type = any
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "env_name" {
  description = "The environment name of the project"
  type        = string
}

variable "namespace" {
  description = "The namespace of the project"
  type        = string
}
