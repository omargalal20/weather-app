locals {
  namespace = "${var.project_name}-${var.env_name}"
}

provider "aws" {
  region  = var.region
  profile = "weather-app"

  default_tags {
    tags = {
      Environment = "Terraform Development Backend"
      Project     = "Weather-App"
      Owner       = "Terraform"
    }
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "${local.namespace}-terraform-state-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "private_bucket_acl" {
  bucket     = aws_s3_bucket.terraform_state.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_versioning" "versioning_configuration" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
