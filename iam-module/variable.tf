variable "iam_group_name" {
  description = "Name of the IAM group"
  type        = string
}

variable "user_names" {
  description = "List of user names"
  type        = list(string)
}

variable "password_length" {
  description = "Length of generated passwords for IAM users"
  type        = number
}

variable "password_reset_required" {
  description = "Whether password reset is required for IAM users"
  type        = bool
}

variable "ec2_role_name" {
  description = "Name of the IAM role for EC2 instances"
  type        = string
}

variable "ec2_role_assume_role_policy" {
  description = "Assume role policy document for EC2 role"
  type        = string
  default = <<EOF
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

variable "ec2_policy_name" {
  description = "Name of the IAM policy for EC2 instance management"
  type        = string
}

variable "ec2_policy_description" {
  description = "Description of the IAM policy for EC2 instance management"
  type        = string
}

variable "ec2_policy" {
  description = "Policy document for the IAM policy for EC2 instance management"
  type        = string
  default = <<EOF
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

variable "admin_policy_name" {
  description = "Name of the administrative IAM policy"
  type        = string
}

variable "admin_policy_description" {
  description = "Description of the administrative IAM policy"
  type        = string
}

variable "admin_policy" {
  description = "Policy document for the administrative IAM policy"
  type        = string
  default = <<EOF
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

variable "ecr_policy_name" {
  description = "Name of the IAM policy for ECR repository management"
  type        = string
}

variable "ecr_policy_description" {
  description = "Description of the IAM policy for ECR repository management"
  type        = string
}

variable "ecr_policy" {
  description = "Policy document for the IAM policy for ECR repository management"
  type        = string
  default = <<EOF
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
