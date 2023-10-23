# module "user_ke_cdso" {
#   source = "./main/User/KE/CDSO"
# }

provider "tfe" {
  hostname = var.hostname # Optional, defaults to Terraform Cloud `app.terraform.io`
  token    = var.token
  version  = "~> 0.49.2"
}


data "tfe_organizations" "foo" {}

#resource "tfe_organization" "test-organization" {
#  name  = "spartzames"
#  email = "spartzames@gmail.com"
#}

data "tfe_project" "foo" {
  name = "awssso"
  organization = data.tfe_organizations.foo.names[0]
}

resource "tfe_workspace" "test" {
  name         = "awsct_identityCenter"
  organization = data.tfe_organizations.foo.names[0]
  project_id = data.tfe_project.foo.id
  tag_names    = ["test", "app"]
#  working_directory = "oidc"
#  vcs_repo {
#    identifier     = "kthong-aft/aft-account-customizations"
#    oauth_token_id = "ot-T2D4n2cRf5igQjS8"
#    branch = "master"
#  }
}

## dynamic provider (INFRA-KALCDSO-DYNAMIC-PROVIDER)
## 1개의 레파지토리, 3개의 디렉토리 (OIDC, IdentityCenterSet, SCPSet) -> 3개의 워크스페이스(TFC)




# data "tfe_organizations" "jsguawsct" {}

# data "tfe_project" "default" {
#   name = "awssso"
#   organization = data.tfe_organizations.jsguawsct.names[0]
# }

# resource "tfe_workspace" "identityCenter" {
#   name         = "awsct_identityCenter"
#   organization = data.tfe_organizations.jsguawsct.names[0]
#   project_id = data.tfe_project.default.id
#   tag_names    = ["test", "sso"]
# }

resource "tfe_variable" "dynamicProviderAuth" {
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  workspace_id = tfe_workspace.test.id
  description  = "a useful description"
}

resource "tfe_variable" "dynamicProviderARN" {
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = "abc"
  category     = "env"
  workspace_id = tfe_workspace.test.id
  description  = "a useful description"
  sensitive    = true
}
