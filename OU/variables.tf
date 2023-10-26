variable "region" {
  default     = "ap-northeast-2"
  type        = string
  description = "The region from which this module will be executed. This MUST be the same region as Control Tower is deployed."
  validation {
    condition     = can(regex("(us(-gov)?|ap|ca|cn|eu|sa|me|af)-(central|(north|south)?(east|west)?)-\\d", var.region))
    error_message = "Variable var: region is not valid."
  }
}

# variable "tfc_aws_audience" {
#   type        = string
#   default     = "aws.workload.identity"
#   description = "The audience value to use in run identity tokens"
# }

# variable "tfc_hostname" {
#   type        = string
#   default     = "app.terraform.io"
#   description = "The hostname of the TFC or TFE instance you'd like to use with AWS"
# }

# variable "tfc_organization_name" {
#   type        = string
#   default     = "KoreanAir_CDSO"
#   description = "The name of your Terraform Cloud organization"
# }

# variable "tfc_project_name" {
#   type        = string
#   default     = "INFRA"
#   description = "The project under which a workspace will be created"
# }

# variable "tfc_identityCenter_workspace_name" {
#   type        = string
#   default     = "my-aws-workspace"
#   description = "The name of the workspace that you'd like to create and connect to AWS"
# }

# variable "tfc_identityCenter_repository" {
#   type        = string
#   default     = "my-workspace-repositories"
#   description = "The name of the workspace repositories that you'd like to create and connect to Bitbucket server"
# }

# variable "tfc_oauth_token_id" {
#   type        = string
#   default     = "ot-5PH2w2nmqH4Sskec"
#   description = ""
# }
