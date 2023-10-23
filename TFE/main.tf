# module "user_ke_cdso" {
#   source = "./main/User/KE/CDSO"
# }

data "tfe_organization" "awsct" {
  name = "jsguawsct"
}

data "tfe_project" "default" {
  name = "Default Project"
  organization = "jsguawsct"
}

resource "tfe_workspace" "identityCenter" {
  name         = "awsct_identityCenter"
  organization = data.tfe_organization.awsct.name
  project_id = data.tfe_project.default.name
  tag_names    = ["test", "sso"]
}

