terraform {
  required_version = ">=1.2.3"

  backend "s3" {
    bucket  = "weather-app-dev-terraform-state-bucket"
    key     = "terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
    profile = "weather-app"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }
  }
}

