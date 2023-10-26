# data "aws_organizations_organization" "organization" {}

# resource "aws_organizations_organizational_unit" "organization_unit" {
#   name      = "Core"
#   parent_id = data.aws_organizations_organization.organization.roots[0].id

# }

# output "aws_organizations_organizational_unit" {
#     value = aws_organizations_organizational_unit.organization_unit.name
# }

# data "aws_organizations_organizational_unit" "ou" {
#   parent_id = data.aws_organizations_organization.organization.roots[0].id
#   name      = output.aws_organizations_organizational_unit.value
# }

# resource "aws_organizations_organizational_unit" "organization_child_unit" {
#   name      = "Network"
#   parent_id = data.aws_organizations_organizational_unit.ou.roots[0].id
#   data.aws_organizations_organizational_unit.output.aws_organizations_organizational_unit.value
# }







# resource "aws_organizations_organizational_unit" "organization_child_unit" {
#   name      = "Network"
#   parent_id = data.aws_organizations_organizational_unit.output.aws_organizations_organizational_unit.value
# }



# # dev/vpc/outputs.tf

# output "vpc_id" {
#     value = aws_vpc.vpc.id
# }


# # dev/ec2/data.tf

# data "terraform_remote_state" "vpc" {
#     backend = "s3"
#     config = {
#       bucket = "terraform"
#       key = "dev/vpc/terraform.tfstate"
#       region = "ap-northeast-2"
#     }
# }


# # dev/ec2/ec2.tf
# locals {
#   vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
# }


# data.aws_organizations_organization.org.roots[0].id



# Organization Root 단위 데이터 소스
data "aws_organizations_organization" "my_org" {}

# "Core" OU 생성
resource "aws_organizations_organizational_unit" "core" {
  name      = "Core"
  parent_id = data.aws_organizations_organization.my_org.roots[0].id
}

# "Network" OU 생성, "Core" OU 아래에 중첩
resource "aws_organizations_organizational_unit" "network" {
  name      = "Network" 
  parent_id = aws_organizations_organizational_unit.core.id  
}