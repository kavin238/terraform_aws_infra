variable "cidr" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr_sub1" {
  description = "CIDR for subnet 1"
  default     = "10.0.0.0/24"
}

variable "cidr_sub2" {
  description = "CIDR for subnet 2"
  default     = "10.0.1.0/24"
}
variable "ami" {
  description = "type of AMI"
  default     = "ami-04a81a99f5ec58529"
}
