data "aws_region" "current" {}

locals {
  endpoint_names = ["logs", "kms", "ssm", "ssmmessages", "ec2messages"]
}

resource "aws_vpc_endpoint" "endpoint" {
  for_each = toset(local.endpoint_names)

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_id]
  security_group_ids  = [aws_security_group.this.id]
  private_dns_enabled = true
}

resource "aws_security_group" "this" {
  name        = "endpoints"
  description = "Security Group for Endpoints"
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "allow outbound traffic over 443"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "allow inbound traffic over 443"
  }

  vpc_id = var.vpc_id
}