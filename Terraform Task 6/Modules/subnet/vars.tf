variable "vpc_id"{}
variable "subnet_count" {
  type = number
  default = 1
}
variable "subnet_cidr_private" {}
variable "availability_zone_private" {}

variable "subnet_name" {}

variable "map_public_ip_on_launch"{}

