# connect github-actions-oidc module
module "github-actions-oidc" {
  source                 = "../../modules/github-actions-oidc"
  allowed_repos_branches = var.allowed_repos_branches
  prefix_name            = var.prefix_name
}

