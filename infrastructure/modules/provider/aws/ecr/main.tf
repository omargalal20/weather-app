resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.name
  image_tag_mutability = "IMMUTABLE"

  tags = {
    Name        = "${var.namespace}-ecr-repo"
    Owner       = "Terraform"
    Environment = "${var.env_name}"
  }
}

resource "aws_ecr_repository_policy" "ecr_repo_policy" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPull",
      "Effect": "Allow",
      "Principal": "*",
        "Action": [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:PutImage",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload",
            "ecr:DescribeRepositories",
            "ecr:GetRepositoryPolicy",
            "ecr:ListImages",
            "ecr:DeleteRepository",
            "ecr:BatchDeleteImage",
            "ecr:SetRepositoryPolicy",
            "ecr:DeleteRepositoryPolicy"
        ]
    }
  ]
}
EOF
}
