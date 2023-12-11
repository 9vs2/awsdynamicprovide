data "aws_region" "current" {}

resource "aws_route53_resolver_endpoint" "inbound_endpoint" {
  name               = "corenetwork-route53-inbound-endpoint"
  direction          = "INBOUND"
  security_group_ids = [aws_security_group.route53_resolver_endpoints.id]

  dynamic "ip_address" {
    for_each = values({ for k, v in var.private_subnet_attributes_by_az : split("/", k)[1] => v if split("/", k)[0] == "endpoints" })
    iterator = subnet
    content {
      subnet_id = subnet.value.id
      ip        = cidrhost(subnet.value.cidr_block, 254)
    }
  }
}

resource "aws_route53_resolver_endpoint" "outbound_endpoint" {
  name               = "corenetwork-route53-outbound-endpoint"
  direction          = "OUTBOUND"
  security_group_ids = [aws_security_group.route53_resolver_endpoints.id]

  dynamic "ip_address" {
    for_each = values({ for k, v in var.private_subnet_attributes_by_az : split("/", k)[1] => v.id if split("/", k)[0] == "endpoints" })
    iterator = subnet_id
    content {
      subnet_id = subnet_id.value
    }
  }
}

resource "aws_route53_resolver_rule" "forwarding_rule" {
  domain_name          = "${data.aws_region.current.name}.amazonaws.com"
  name                 = "corenetwork-route53-forwadingrule-amazonaws"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint.id

  dynamic "target_ip" {
    for_each = values({ for k, v in var.private_subnet_attributes_by_az : split("/", k)[1] => v if split("/", k)[0] == "endpoints" })
    iterator = subnet
    content {
      ip = cidrhost(subnet.value.cidr_block, 254)
    }
  }
}

