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
  ec2_policy_name = "ec2-policy"
  ec2_policy_description = "Allows specific EC2 actions in ap-southeast-1 region and denies other instance types"
  admin_policy_name ="admin-policy"
  admin_policy_description = "Administrative policy"
  ecr_policy_name = "ecr-policy"
  ecr_policy_description = "Allows creating ECR repositories"
}
