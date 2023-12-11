output "vpc_attributess_id" {
  description = "pools_level_1"
  value       = module.vpc.vpc_attributes.id
}

output "private_subnet_attributes_by_az" {
  description = "pools_level_2"
  value       = module.vpc.private_subnet_attributes_by_az
}

output "vpc_attributes_cidr_block" {
  description = "pools_level_3"
  value       = module.vpc.vpc_attributes.cidr_block
}