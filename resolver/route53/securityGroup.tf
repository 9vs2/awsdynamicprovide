resource "aws_security_group" "route53_resolver_endpoints" {
  name        = "corenetwork-route53-resolver-endpoints-sg"
  description = "Security Group for Route53 Resolver Endpoints"
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["10.248.0.0/20"]
    description = "allow dns tcp traffic"
  }
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.248.0.0/20"]
    description = "allow dns udp traffic"
  }
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["10.248.0.0/20"]
    description = "allow dns tcp outbound traffic"
  }
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.248.0.0/20"]
    description = "allow dns udp outbound traffic"
  }
  vpc_id = var.vpc_id
}