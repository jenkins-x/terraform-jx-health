variable "jx_git_url" {
  description = "URL for the Jenkins X cluster git repository"
  type        = string
  default     = ""
}

variable "jx_bot_username" {
  description = "Bot username used to interact with the Jenkins X cluster git repository"
  type        = string
  default     = ""
}

variable "jx_bot_token" {
  description = "Bot token used to interact with the Jenkins X cluster git repository"
  type        = string
  default     = ""
}

variable "jx_kh_check_version" {
  description = "The helm version of the jx-kh-check chart"
  type        = string
  default     = "0.0.78"
}

variable "kuberhealthy_terraform_drift_check_version" {
  description = "The helm version of the kuberhealthy-terraform-drift-check chart"
  type        = string
  default     = "0.1.2"
}

variable "tf_drift_secret_map" {
  description = "Map of secrets to provide as secret environment variables to the terraform drift health check"
  type = map(string)
  default = {}
}


