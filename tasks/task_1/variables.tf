# variables for task 1 uncomment for local execute
# variable "aws_profile" {}
# variable "aws_region" {}
variable "env_prefix" {
  default = "task-1"
}
# variable "aws_config_path" {
#   type = list(string)
# }
# variable "aws_creds_path" {
#   type = list(string)
# }
variable "allowed_repos_branches" {
  description = "GitHub repos/branches allowed to assume the IAM role."
  type = list(object({
    org    = string
    repo   = string
    branch = string
  }))
  default = [
    {
      org    = "askhat-zab"
      repo   = "rsschool-devops-course-tasks"
      branch = "main"
    }
  ]
}

variable "name" {
  type    = string
  default = "github-actions-oidc"
}
