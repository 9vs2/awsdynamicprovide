# module "ipam" {
#   source               = "./ipam"
#   test_network_account = ["482012816675"]
#   # sandbox_ou_arn = ["arn:aws:organizations::335083040971:ou/o-eyfolyredl/ou-uhrw-69s2z3ft"]
# }

module "vpc" {
  source = "./vpc"
  # vpc_ipv4_ipam_pool_id = module.ipam.pools_level_2["ap-northeast-2/core-network"].id
}

# module "ram" {
#   source                      = "./ram"
#   depends_on                  = [module.vpc]
#   endpoints_resolver_rule_arn = module.route53.endpoints_resolver_rule_arn
# }

module "route53" {
  source                          = "./route53"
  vpc_id                          = module.vpc.vpc_attributess_id
  private_subnet_attributes_by_az = module.vpc.private_subnet_attributes_by_az
}

module "endpoints" {
  source    = "./endpoints"
  vpc_id    = module.vpc.vpc_attributess_id
  subnet_id = module.vpc.private_subnet_attributes_by_az["endpoints/ap-northeast-2a"].id
  vpc_cidr  = module.vpc.vpc_attributes_cidr_block
}


