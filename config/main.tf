module "scp_root" {
  source    = "../../modules/SCP"
  for_each  = fileset(path.root, "task/SCP/policies/scp_root/*.json")
  json_file = each.value
  target_id   = data.aws_organizations_organizational_units.root.id
}

module "scp_core" {
  source    = "../../modules/SCP"
  for_each  = fileset(path.root, "task/SCP/policies/scp_core/*.json")
  json_file = each.value
  target_id   = data.aws_organizations_organizational_unit.core_ou.id
}