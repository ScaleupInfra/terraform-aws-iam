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
