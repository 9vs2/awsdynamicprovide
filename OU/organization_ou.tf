data "aws_organizations_organization" "organization" {}

resource "aws_organizations_organizational_unit" "organization_unit" {
  name      = "Core"
  parent_id = data.aws_organizations_organization.organization.roots[0].id

}

data "aws_organizations_organizational_unit" "ou" {
  parent_id = data.aws_organizations_organization.organization.roots[0].id
  name      = "Core"
}

resource "aws_organizations_organizational_unit" "organization_child_unit" {
  name      = "Network"
  parent_id = data.aws_organizations_organizational_unit.ou.id

}