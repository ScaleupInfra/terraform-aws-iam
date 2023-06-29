resource "aws_iam_group" "my_group" {
  name = "autoscaleupinfra"
}

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
    "user10"
  ]
}

resource "aws_iam_user" "my_users" {
  count = length(local.users)
  name  = local.users[count.index]
}

resource "aws_iam_user_login_profile" "my_users_login_profile" {
  count                   = length(local.users)
  user                    = aws_iam_user.my_users[count.index].name
  password_length         = 16
  password_reset_required = false
}

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

resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2-policy"
  description = "Allows creating EC2 instances"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowEC2",
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
}
EOF
}

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

resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}

resource "aws_iam_user_policy_attachment" "ec2_full_access_attachment" {
  count      = length(local.users)
  user       = aws_iam_user.my_users[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_group_policy_attachment" "ec2_full_access_attachment" {
  group      = aws_iam_group.my_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "local_file" "iam_user_passwords" {
  count    = length(local.users)
  filename = "iam_user_passwords.txt"
  content  = "Username: ${aws_iam_user.my_users[count.index].name}\nPassword: ${aws_iam_user_login_profile.my_users_login_profile[count.index].password}"
}

output "user_passwords" {
  value = {
    for i, user in local.users : user => aws_iam_user_login_profile.my_users_login_profile[i].password
  }
}
