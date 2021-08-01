
//For public subnet
variable "availability_zone_public"{
    type = list(string)
    default = ["ap-south-1a"]
}
variable "public_subnet_cidr" {
    type = list(string)
    default = ["10.0.1.0/24"]
  
}
variable "public_subnet_name" {
  type = string
  default = "Frontend-Server"
}



// For EC2 Instance

variable "instance_type_list"{
  type = list(string)
  default = ["t2.micro"]
}