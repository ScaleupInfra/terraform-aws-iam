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
  admin_policy                     = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": \"*\",\n      \"Resource\": \"*\"\n    }\n  ]\n}"
  ecr_policy                       = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"AllowECR\",\n      \"Effect\": \"Allow\",\n      \"Action\": \"ecr:*\",\n      \"Resource\": \"*\"\n    }\n  ]\n}"
  ec2_role_assume_role_policy      = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"\",\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n         \"AWS\": \"*\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}"
  ec2_policy                       = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": [\n        \"ec2:*\"\n      ],\n      \"Resource\": \"*\",\n      \"Condition\": {\n        \"StringEquals\": {\n          \"aws:RequestedRegion\": \"ap-southeast-1\"\n        }\n      }\n    },\n    {\n      \"Effect\": \"Deny\",\n      \"Action\": \"ec2:*\",\n      \"Resource\": \"*\",\n      \"Condition\": {\n        \"ForAnyValue:StringNotLike\": {\n          \"ec2:InstanceType\": [\n            \"t2.micro\"\n          ]\n        }\n      }\n    }\n  ]\n}"
}
