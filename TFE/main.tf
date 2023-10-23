# module "user_ke_cdso" {
#   source = "./main/User/KE/CDSO"
# }

data "tfe_organizations" "jsguawsct" {}

data "tfe_project" "default" {
  name = "awssso"
  organization = data.tfe_organizations.awsct.names[0]
}

resource "tfe_workspace" "identityCenter" {
  name         = "awsct_identityCenter"
  organization = data.tfe_organizations.awsct.names[0]
  project_id = data.tfe_project.default.id
  tag_names    = ["test", "sso"]
}

resource "tfe_variable" "dynamicProviderAuth" {
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  workspace_id = tfe_workspace.identityCenter.id
  description  = "a useful description"
}

resource "tfe_variable" "dynamicProviderARN" {
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = "abc"
  category     = "env"
  workspace_id = tfe_workspace.identityCenter.id
  description  = "a useful description"
  sensitive    = true
}
