# module "user_ke_cdso" {
#   source = "./main/User/KE/CDSO"
# }

data "tfe_organization" "awsct" {
  name = "jsguawsct"
}

resource "tfe_workspace" "identityCenter" {
  name         = "awsct_identityCenter"
  organization = tfe_organization.awsct.name
  tag_names    = ["test", "sso"]
}

