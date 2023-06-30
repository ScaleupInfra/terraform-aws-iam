# Create an IAM group named "autoscaleupinfra"
resource "aws_iam_group" "my_group" {
  name = "autoscaleupinfra"
}

# Define a list of user names
locals {
  users = [
    "learning@infrasity.com",
    "user2",
    "user3",
    "user4",
    "user5",
    "user6",
    "user7",
    "user8",
    "user9",
    "user10",
    "admin_user1",
    "admin_user2"
  ]
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
  password_length         = 16
  password_reset_required = false
}

# Create an IAM role named "ec2-role" for EC2 instances
resource "aws_iam_role" "ec2_role" {
  name               = "ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
         "AWS": "*"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Create an IAM policy named "ec2-policy" for EC2 instance management
resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2-policy"
  description = "Allows specific EC2 actions in ap-southeast-1 region and denies other instance types"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:RequestedRegion": "ap-southeast-1"
        }
      }
    },
    {
      "Effect": "Deny",
      "Action": "ec2:*",
      "Resource": "*",
      "Condition": {
        "ForAnyValue:StringNotLike": {
          "ec2:InstanceType": [
            "t2.micro"
          ]
        }
      }
    }
  ]
}
EOF
}

# Create an IAM policy named "admin-policy" for administrative privileges
resource "aws_iam_policy" "admin_policy" {
  name        = "admin-policy"
  description = "Administrative policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
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

# Create an IAM policy named "ecr-policy" for ECR repository management
resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr-policy"
  description = "Allows creating ECR repositories"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowECR",
      "Effect": "Allow",
      "Action": "ecr:*",
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the ECR policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}

# Output the user passwords as a map
output "user_passwords" {
  value = {
    for i, user in local.users : user => aws_iam_user_login_profile.my_users_login_profile[i].password
  }
}
