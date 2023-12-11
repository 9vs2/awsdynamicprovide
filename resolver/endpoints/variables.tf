variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to deploy the infrastructure."
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "ID of subnet to deploy the instance in."
  default     = ""
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of the VPC to deploy the instance in."
  default     = ""
}
