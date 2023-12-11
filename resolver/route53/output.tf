output "endpoints_resolver_rule_arn" {
  description = "endpoints_resolver_rule_arn"
  value       = aws_route53_resolver_rule.forwarding_rule.arn
}

output "endpoints_resolver_rule_id" {
  description = "endpoints_resolver_rule_arn"
  value       = aws_route53_resolver_rule.forwarding_rule.id
}
