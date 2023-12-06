resource "aws_config_config_rule" "this" {
  rule_json = var.config_rule
}