##############################################################
#
# IAM Role for Server
#
##############################################################


resource "aws_iam_role" "server_iam_role" {
  name = "${var.namespace}-server-iam-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "server_iam_policy" {
  name        = "${var.namespace}-server-iam-policy"
  description = "IAM policy for ${var.namespace}-server instance"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "server_iam_role_policy_attachment" {
  policy_arn = aws_iam_policy.server_iam_policy.arn
  role       = aws_iam_role.server_iam_role.name
}
