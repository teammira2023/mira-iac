variable "ec2_count" {
  default = "1"
}

variable "ami_id" {}

variable "tenancy" {
  default = "dedicated"
}
variable "instance_name" {}
variable "instance_type" {}
variable "subnet_id" {}
