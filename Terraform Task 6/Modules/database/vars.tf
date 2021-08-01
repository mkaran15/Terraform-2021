variable "databse_identifier" {
    type    = string 
    default = " database"
}
variable "allocated_storage" {
    type = number
    default = 10
}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "db_name" {
    type = string
    default = "amazonRDS"
}
variable "db_username" {}
variable "db_passwd" {}
variable "publicly_accessible" {}
variable "skip_final_snapshot" {}
variable "db_subnet_group_name" {}

variable "vpc_security_group_ids" {}

