data "aws_organizations_organization" "org" {}

data "aws_organizations_organizational_units" "root" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

data "aws_organizations_organizational_unit" "core_ou" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
  name      = "CORE"
}