# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Change this to your preferred region
}

# Define variables
variable "system_name" {
  description = "Name of the system"
  default     = "Cloud Devbox"
}

variable "system_id" {
  description = "ID of the system"
  default     = "cloud-devbox"
}

variable "uuid_suffix" {
  description = "UUID suffix for unique resource naming"
  default     = "asdf1234" 
}

variable "account_id" {
  description = "AWS account ID"
  default     = "123456789012"
}
