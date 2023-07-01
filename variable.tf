variable "iam_group_name" {
  description = "Name of the IAM group"
  type        = string
  default     = "autoscaleupinfra"
}

variable "user_names" {
  description = "List of user names"
  type        = list(string)
  default     = [
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

variable "password_length" {
  description = "Length of generated passwords for IAM users"
  type        = number
  default     = 16
}

variable "password_reset_required" {
  description = "Whether password reset is required for IAM users"
  type        = bool
  default     = false
}

variable "ec2_role_name" {
  description = "Name of the IAM role for EC2 instances"
  type        = string
  default     = "ec2-role"
}

variable "ec2_role_assume_role_policy" {
  description = "Assume role policy document for EC2 role"
  type        = string
  default     = <<EOF
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
  default     = "ec2-policy"
}

variable "ec2_policy_description" {
  description = "Description of the IAM policy for EC2 instance management"
  type        = string
  default     = "Allows specific EC2 actions in ap-southeast-1 region and denies other instance types"
}

variable "ec2_policy" {
  description = "Policy document for the IAM policy for EC2 instance management"
  type        = string
  default     = <<EOF
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
  default     = "admin-policy"
}

variable "admin_policy_description" {
  description = "Description of the administrative IAM policy"
  type        = string
  default     = "Administrative policy"
}

variable "admin_policy" {
  description = "Policy document for the administrative IAM policy"
  type        = string
  default     = <<EOF
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
  default     = "ecr-policy"
}

variable "ecr_policy_description" {
  description = "Description of the IAM policy for ECR repository management"
  type        = string
  default     = "Allows creating ECR repositories"
}

variable "ecr_policy" {
  description = "Policy document for the IAM policy for ECR repository management"
  type        = string
  default     = <<EOF
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
