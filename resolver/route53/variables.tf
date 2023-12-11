variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to deploy the infrastructure."
  default     = ""
}

variable "private_subnet_attributes_by_az" {
  description = "private_subnet_attributes_by_az"
  type        = map(any)
  # type = string
}

variable "forwarding_rules" {
  type        = map(any)
  description = "Forwarding rules to on-premises DNS"
  default = {
    "itro" = {
      domain_name = "itro.koreanair.com"
      rule_type   = "FORWARD"
      target_ip   = ["8.8.8.8"]
    }
    "kalis" = {
      domain_name = "kalis.koreanair.com"
      rule_type   = "FORWARD"
      target_ip   = ["8.8.8.8"]
    }
  }
}