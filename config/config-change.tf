data "aws_organizations_organization" "org" {}

data "aws_organizations_organizational_unit" "security" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
  name      = "Security"
}

# config rule 정의 JSON
locals {
  config_rule_json = templatefile("../policies/config_chagnge/config-change.json", {
    ouid = data.aws_organizations_organizational_units.security.id
  })
}

module "config_change" {
  source    = "../modules/config"
  for_each  = fileset(path.root, "config/policies/config_change/*.json")
  json_file = each.value
}