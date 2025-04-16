variable "access_key" {
  
}

variable "secret_key" {
  
}

variable "aws_region" {
  
}

variable "aws_account_id" {
  
}

variable "enable_flask" {
  description = "Enable Flask routing in the ALB listener"
  type        = bool
  default     = true  # Set default as true or false based on your needs
}

variable "enable_express" {
  description = "Enable Express routing in the ALB listener"
  type        = bool
  default     = true  # Set default as true or false based on your needs
}