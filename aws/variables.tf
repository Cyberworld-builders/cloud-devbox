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

variable "vpc_id" {
  description = "VPC Id"
}

variable "public_subnet_id" {
  description = "Public Subnet Id"
}

variable "ubuntu_20_04_ami" {
  description = "Ubuntu 20.04 AMI"
  default = "ami-0a0e5d9c7acc336f1"
}