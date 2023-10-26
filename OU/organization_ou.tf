data "aws_organizations_organization" "organization" {}

resource "aws_organizations_organizational_unit" "organization_unit" {
  name      = "Core"
  parent_id = data.aws_organizations_organization.example.roots[0].id

}