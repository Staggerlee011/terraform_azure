variable "region" {
  type        = "string"
  description = "Default region for all Azure objects"
  default     = "West US"
}

variable "zones" {
  default = ["us-east-1a", "us-east-1b"]
}