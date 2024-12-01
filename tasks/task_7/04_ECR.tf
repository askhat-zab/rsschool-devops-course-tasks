resource "aws_ecr_repository" "admin_ecr_repo" {
  name         = "${var.env_prefix}-repository"
  force_delete = true
  tags = {
    Name = "${var.env_prefix}-repository"
  }
}

# IAM Role for EC2 Instances
resource "aws_iam_role" "ec2_role" {
  name               = "${var.env_prefix}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}

data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# IAM Policy for ECR Access
resource "aws_iam_policy" "ecr_access_policy" {
  name        = "${var.env_prefix}-ecr-access-policy"
  description = "Policy to allow EC2 instances to access ECR"
  policy      = data.aws_iam_policy_document.ecr_access_policy.json
}

data "aws_iam_policy_document" "ecr_access_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:*",
    ]
    resources = ["*"]
  }
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach_ecr_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ecr_access_policy.arn
}

