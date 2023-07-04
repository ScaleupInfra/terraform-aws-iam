# Create an IAM group named "autoscaleupinfra"
resource "aws_iam_group" "my_group" {
  name = var.iam_group_name
}

# Define a list of user names
locals {
  users = var.user_names
}

# Create IAM users using the names from the list
resource "aws_iam_user" "my_users" {
  count = length(local.users)
  name  = local.users[count.index]
}

# Configure login profiles for IAM users with generated passwords
resource "aws_iam_user_login_profile" "my_users_login_profile" {
  count                   = length(local.users)
  user                    = aws_iam_user.my_users[count.index].name
  password_length         = var.password_length
  password_reset_required = var.password_reset_required
}

locals {
  policy_data = jsondecode(file("${path.module}/policy.json"))
}

# Create an IAM role named "ec2-role" for EC2 instances
resource "aws_iam_role" "ec2_role" {
  name               = var.ec2_role_name
  assume_role_policy = jsonencode(local.policy_data.ec2_role_assume_role_policy)
}

# Create an IAM policy named "ec2-policy" for EC2 instance management
resource "aws_iam_policy" "ec2_policy" {
  name        = var.ec2_policy_name
  description = var.ec2_policy_description
  policy      = jsonencode(local.policy_data.ec2_policy)
}

# Create an IAM policy named "admin-policy" for administrative privileges
resource "aws_iam_policy" "admin_policy" {
  name        = var.admin_policy_name
  description = var.admin_policy_description
  policy      = jsonencode(local.policy_data.admin_policy)
}

# Attach the EC2 policy to the IAM group
resource "aws_iam_group_policy_attachment" "ec2_policy_attachment" {
  group      = aws_iam_group.my_group.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

# Attach the admin policy to the IAM group
resource "aws_iam_group_policy_attachment" "admin_policy_attachment" {
  group      = aws_iam_group.my_group.name
  policy_arn = aws_iam_policy.admin_policy.arn
}

# Attach the EC2 policy to the IAM users
resource "aws_iam_user_group_membership" "ec2_policy_group_membership" {
  count  = length(local.users)
  user   = aws_iam_user.my_users[count.index].name
  groups = [aws_iam_group.my_group.name]
}

# Create an IAM policy named "ecr-policy" for ECR access
resource "aws_iam_policy" "ecr_policy" {
  name        = var.ecr_policy_name
  description = var.ecr_policy_description
  policy      = jsonencode(local.policy_data.ecr_policy)
}

# Attach the ECR policy to the IAM group
resource "aws_iam_group_policy_attachment" "ecr_policy_attachment" {
  group      = aws_iam_group.my_group.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}
