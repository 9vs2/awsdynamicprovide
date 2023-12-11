# resource "aws_ec2_transit_gateway" "this" {
#   description = "Core Network Transit Gateway"

#   # auto_accept_shared_attachments  = "disable"
#   # default_route_table_association = "enable"
#   # default_route_table_propagation = "enable"
#   # dns_support                     = "enable"
#   # vpn_ecmp_support                = "disable"
#   tags = {
#     Name = "tgw-core-network"
#   }
# }

# resource "aws_ec2_transit_gateway_route" "this" {
#   destination_cidr_block         = "0.0.0.0/0"
#   transit_gateway_attachment_id  = module.vpc.transit_gateway_attachment_id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway.this.association_default_route_table_id
# }