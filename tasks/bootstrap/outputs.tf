# Output the access key
output "access_key_id" {
  value = module.iam-user.admin_key.id
}

# Output the secret access key like sensitive output
output "secret_access_key" {
  value     = module.iam-user.admin_key.secret
  sensitive = true
}
