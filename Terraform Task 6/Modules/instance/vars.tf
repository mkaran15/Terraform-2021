 variable "no_of_nodes"{}
 variable "ami_id"{}
 variable "instance_type"{}
 variable "key_name"{}
 variable "subnet_id"{}
 variable "instance_tag_name"{
     type =string
     default ="HelloWorld"
 }
 variable "instance_tag_project"{
     type = string
     default = "MyProject"
 }
 variable "availability_zone" {}
 variable "vpc_security_group_ids" {}