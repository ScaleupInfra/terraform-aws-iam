module "iam" {
  source = "./iam-module"

  # the default values for the variables
  iam_group_name  = "autoscaleupinfra"
  user_names =  [
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
  password_length         = 16
  password_reset_required = false
  ec2_role_name  = "ec2-role"
  ec2_role_assume_role_policy = <<EOF
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
  ec2_policy_name = "ec2-policy"
  ec2_policy_description = "Allows specific EC2 actions in ap-southeast-1 region and denies other instance types"
  ec2_policy = <<EOF
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
  admin_policy_name ="admin-policy"
  admin_policy_description = "Administrative policy"
  admin_policy = <<EOF
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
  ecr_policy_name = "ecr-policy"
  ecr_policy_description = "Allows creating ECR repositories"
  ecr_policy = <<EOF
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
