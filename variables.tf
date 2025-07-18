variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"

}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "aws_token" {
  description = "AWS session token"
  type        = string
  sensitive   = true
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = "Tenancy of instances launched in the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "public-subnet-1-cidr" {
  description = "CIDR block for Public Subnet 1"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public-subnet-2-cidr" {
  description = "CIDR block for Public Subnet 2"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private-subnet-1-cidr" {
  description = "CIDR block for Private Subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private-subnet-2-cidr" {
  description = "CIDR block for Private Subnet 2"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private-subnet-3-cidr" {
  description = "CIDR block for Private Subnet 3"
  type        = string
  default     = "10.0.4.0/24"
}

variable "private-subnet-4-cidr" {
  description = "CIDR block for Private Subnet 4"
  type        = string
  default     = "10.0.5.0/24"
}

variable "my_public_ip" {
  description = "Your current public IP address"
  type        = string
  # Will be fetched automatically if not specified
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}
variable "enable_bastion" {
  description = "Enable Bastion Host"
  type        = bool
}
