# create admin IAM user
resource "aws_iam_user" "admin" {
  name = var.aws_admin_user
  tags = {
    name = "${var.env_prefix}-admin_user"
  }
}

# attach necessary policies to the user
resource "aws_iam_user_policy_attachment" "admin_ec2" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy_attachment" "admin_route53" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_user_policy_attachment" "admin_s3" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "admin_iam" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_user_policy_attachment" "admin_vpc" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_user_policy_attachment" "admin_sqs" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_user_policy_attachment" "admin_eventbridge" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
}

# create new access key for the admin user
resource "aws_iam_access_key" "admin_key" {
  user = aws_iam_user.admin.name
}


