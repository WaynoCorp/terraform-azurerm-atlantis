
variable "name" {
  description = "names to be applied to resources"
  type        = string
}

variable "location" {
  description = "the azure region"
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = ""
  type        = string
}

variable "tags" {
  description = ""
  type        = map(string)
  default     = null
}

variable "github_user" {
  description = "the git hub user"
  type        = string
}

variable "github_token" {
  description = "The git hub access token with repo scope"
  type        = string
  sensitive   = true
}

variable "tfe_token" {
  description = "the tfe / cloud user or team token"
  type        = string
  sensitive   = true
  default     = null
}

variable "github_webhook_secret" {
  description = ""
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = ""
  type        = string
}

variable "enabled" {
  description = "Whether to launch the container instances."
  type        = bool
  default     = true
}

variable "is_public" {
  description = "Whether the container instance will have a public ip and dns"
  type        = bool
  default     = true
}

variable "allowed_ips" {
  description = "list of ips"
  type        = list(string)
  default     = []
}

variable "github_repo_allowlist" {
  description = ""
  type        = string
}

variable "network_profile_id" {
  description = "The network profile id. Required if is_public is false"
  type        = string
  default     = null
}

variable "dns_name_label" {
  description = ""
  type        = string
  default     = "atlantis"
}

variable "container_cpu" {
  description = ""
  type        = number
  default     = 1
}

variable "container_memory" {
  description = ""
  type        = number
  default     = 2
}

## auto-scale
variable "alert_emails" {
  description = ""
  type = list(string)
  default = []
}