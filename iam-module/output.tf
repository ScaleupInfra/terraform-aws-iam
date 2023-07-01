# Output the user passwords as a map
output "user_passwords" {
  value = {
    for i, user in local.users : user => aws_iam_user_login_profile.my_users_login_profile[i].password
  }
}
