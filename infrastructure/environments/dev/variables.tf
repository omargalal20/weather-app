variable "region" {
  description = "AWS Region"
  default     = "us-west-2"
  type        = string
}

variable "profile" {
  description = "The AWS CLI profile of the project"
  default     = "weather-app"
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

# --- Secrets ---

variable "EC2_KEY_PAIR_PATH" {
  description = "The local key pair path needed to store the ec2 ssh key"
  type        = string
}

