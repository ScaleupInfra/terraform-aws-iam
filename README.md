![Logo](https://autoscaleupinfra-buckets.s3.ap-northeast-1.amazonaws.com/1.png?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEHgaCmFwLXNvdXRoLTEiRzBFAiEArvjtoCQOyS0UUaYg9iuoDTzlT9dcAZsrFMhqH7WhRkECICYc0exc6U4C3r7jkgt04f9F%2Feds5%2B867eiSdBd6NHkpKu0CCNH%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMODM0Mjc3NzY3NDM2IgzD2wylrkOqA1M9rgsqwQKdB2dOXEwxTk3rcw5eeoWvsZMqSizn%2FiEK5sqzSnWbbJXovNwBSFgSJW8E4WClk13wWepFObrGwBDf6HejBN1ozg%2BhuivCOSx5bEjhmy%2FvoKmoV%2Bt%2FrnIffXsQajjbwpRe3rswK1YosvR2%2BJbvFIy6Q33l4JVdE9e30ldorSE6ION3x4Jk0%2FAa4ZgZFBcuLIP9m%2BbCITnq8RMH6p0bAvUu%2FrflKkPlgNWIGWL3vWqp2RBJSrJq5JlOC%2BsUL9aud%2FW1WqV3hyxeBJAsWBKWKjzxuQP6NvD5DZQUmietpsagP7bJ300FbVJj3HBg826aJgWTHlxPaB5fYo8TV1H5Ah%2BFRk7oiNnjYqwStNiAaESbYjvZZzKCRqJV%2FPqpnxgrjakwphQT3xaLSxg0kcl567VCBfBRt%2F3KhH9xxDBemmZgoCEwz4fQpAY6swJAzZGvPhKv0Q7Kzz8lQjUgqvGzgAqbj115jp9hpZw3U%2BpxgJIGEWBuY1PZbcvpA12tuTw2HXWDCFh3TTKdOxapzc%2B%2BUPcBlP65fSZlacEUFeswiV4ujEvbQTvTrgvOYAO6mluh9wIBqn0XHnLIikbv3XlVlP%2BIe4dzdkC0oGwEDDnK5tVChCwlYA%2FYo2axu8pRx3qKyWKJ5J4ddok8uVxvpXk1Dz3%2FPqjFqbWfiOs%2FxtZUDlBHGpFOmJBGxbCjTSppw3VDCo1y2COP6CokHMG8lJAXL%2BMLe0%2FmsvIdJy%2Fk6TbqXA1oCJzvEUY4N%2F%2BthylubX7DOf3jdVl4Ejv2cd9fJJhBRzOefZiopOoymZqfVl9LLQe6SeBhCbhKml7fpYfd5se29t3hNsTynkrDmCfHgtwp&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230622T102749Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIA4EPWUPEGC2EZKCF7%2F20230622%2Fap-northeast-1%2Fs3%2Faws4_request&X-Amz-Signature=aa25867addd41652a115235bdce59790c9c03fb62c30d44598baa8a5844fec72)


## Badges

[![Terraform AWS](https://github.com/ScaleupInfra/terraform-aws-s3-bucket/actions/workflows/main.yml/badge.svg)](https://github.com/ScaleupInfra/terraform-aws-s3-bucket/actions/workflows/main.yml)

# IAM Module

This Terraform module creates an IAM group and associated IAM users with login profiles, an IAM role for EC2 instances, and IAM policies for EC2 and ECR management.

## Usage

1. Install and configure Terraform on your local machine.
2. Provide your AWS access key and secret key in the `provider.tf` file.
3. Modify the variables in the `variable.tf` file to customize the IAM group and user configurations.
4. Run `terraform init` to initialize the Terraform configuration.
5. Run `terraform apply` to create the IAM resources.

## Module Inputs

The module accepts the following input variables:

- `iam_group_name`: Name of the IAM group.
- `user_names`: List of user names to create.
- `password_length`: Length of generated passwords for IAM users.
- `password_reset_required`: Whether password reset is required for IAM users.
- `ec2_role_name`: Name of the IAM role for EC2 instances.
- `ec2_role_assume_role_policy`: Assume role policy document for EC2 role.
- `ec2_policy_name`: Name of the IAM policy for EC2 instance management.
- `ec2_policy_description`: Description of the IAM policy for EC2 instance management.
- `ec2_policy`: Policy document for the IAM policy for EC2 instance management.
- `admin_policy_name`: Name of the administrative IAM policy.
- `admin_policy_description`: Description of the administrative IAM policy.
- `admin_policy`: Policy document for the administrative IAM policy.
- `ecr_policy_name`: Name of the IAM policy for ECR repository management.
- `ecr_policy_description`: Description of the IAM policy for ECR repository management.
- `ecr_policy`: Policy document for the IAM policy for ECR repository management.

## Outputs

The module provides the following output:

- `user_passwords`: A map of user names to their generated passwords.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|[admin\_policy](#input\_admin\_policy) | Policy document for the administrative IAM policy | `string` | `"{\r\n  \"Version\": \"2012-10-17\",\r\n  \"Statement\": [\r\n    {\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": \"*\",\r\n      \"Resource\": \"*\"\r\n    }\r\n  ]\r\n}\r\n"` | no |
|[admin\_policy\_description](#input\_admin\_policy\_description) | Description of the administrative IAM policy | `string` | n/a | yes |
| [admin\_policy\_name](#input\_admin\_policy\_name) | Name of the administrative IAM policy | `string` | n/a | yes |
|[ec2\_policy](#input\_ec2\_policy) | Policy document for the IAM policy for EC2 instance management | `string` | `"{\r\n  \"Version\": \"2012-10-17\",\r\n  \"Statement\": [\r\n    {\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"ec2:*\"\r\n      ],\r\n      \"Resource\": \"*\",\r\n      \"Condition\": {\r\n        \"StringEquals\": {\r\n          \"aws:RequestedRegion\": \"ap-southeast-1\"\r\n        }\r\n      }\r\n    },\r\n    {\r\n      \"Effect\": \"Deny\",\r\n      \"Action\": \"ec2:*\",\r\n      \"Resource\": \"*\",\r\n      \"Condition\": {\r\n        \"ForAnyValue:StringNotLike\": {\r\n          \"ec2:InstanceType\": [\r\n            \"t2.micro\"\r\n          ]\r\n        }\r\n      }\r\n    }\r\n  ]\r\n}\r\n"` | no |
| [ec2\_policy\_description](#input\_ec2\_policy\_description) | Description of the IAM policy for EC2 instance management | `string` | n/a | yes |
| [ec2\_policy\_name](#input\_ec2\_policy\_name) | Name of the IAM policy for EC2 instance management | `string` | n/a | yes |
| [ec2\_role\_assume\_role\_policy](#input\_ec2\_role\_assume\_role\_policy) | Assume role policy document for EC2 role | `string` | `"{\r\n  \"Version\": \"2012-10-17\",\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"\",\r\n      \"Effect\": \"Allow\",\r\n      \"Principal\": {\r\n         \"AWS\": \"*\"\r\n      },\r\n      \"Action\": \"sts:AssumeRole\"\r\n    }\r\n  ]\r\n}\r\n"` | no |
| [ec2\_role\_name](#input\_ec2\_role\_name) | Name of the IAM role for EC2 instances | `string` | n/a | yes |
|[ecr\_policy](#input\_ecr\_policy) | Policy document for the IAM policy for ECR repository management | `string` | `"{\r\n  \"Version\": \"2012-10-17\",\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"AllowECR\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": \"ecr:*\",\r\n      \"Resource\": \"*\"\r\n    }\r\n  ]\r\n}\r\n"` | no |
| [ecr\_policy\_description](#input\_ecr\_policy\_description) | Description of the IAM policy for ECR repository management | `string` | n/a | yes |
|[ecr\_policy\_name](#input\_ecr\_policy\_name) | Name of the IAM policy for ECR repository management | `string` | n/a | yes |
| [iam\_group\_name](#input\_iam\_group\_name) | Name of the IAM group | `string` | n/a | yes |
| [password\_length](#input\_password\_length) | Length of generated passwords for IAM users | `number` | n/a | yes |
|[password\_reset\_required](#input\_password\_reset\_required) | Whether password reset is required for IAM users | `bool` | n/a | yes |
|[user\_names](#input\_user\_names) | List of user names | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
|[user\_passwords](#output\_user\_passwords) | Output the user passwords as a map |

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.my_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.admin_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.ec2_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.admin_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ec2_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecr_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.my_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.ec2_policy_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_login_profile.my_users_login_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile) | resource |


## Dependencies

This module has the following dependencies:

- Terraform version 0.12 or later.
- AWS provider version 3.0 or later.


## Providers

| Name | Version |
|------|---------|
| [aws](#provider\_aws) | 3.0 |


## Run Locally

Clone the project

```bash
  git clone https://github.com/ScaleupInfra/terraform-aws-s3-bucket.git
```

Go to the project directory

```bash
  cd terraform-aws-s3-bucket
  teraform init
  terraform plan 
  teraform apply -auto-approve
```

Destroy Infrastructrre  dependencies

```bash
  terraform destroy -auto-approve
```


## 🔗 Links

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/)


## Authors

- [@octokatherine](https://www.github.com/octokatherine)


## Contributing

Contributions are always welcome!

If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

See `contributing.md` for ways to get started.

Please adhere to this project's `code of conduct`.


## Support

Join our Open Source Community on [Slack](https://app.slack.com/huddle/T05EL2WSB2M/C05EL2WTMA5). It's FREE for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally sweet infrastructure.
