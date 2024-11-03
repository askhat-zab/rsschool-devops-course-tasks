variable "env_prefix" {
  default = "task-1"
}

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

variable "prefix_name" {
  type    = string
  default = "github-actions-oidc"
}
