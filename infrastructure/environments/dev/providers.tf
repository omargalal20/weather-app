provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Environment = "development"
      Project     = "weather-app"
      Owner       = "terraform"
    }
  }
}
