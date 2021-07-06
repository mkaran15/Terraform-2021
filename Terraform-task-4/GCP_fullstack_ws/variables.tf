// For GCP Instance
variable "region"{
    type = string
    default = "us-central1"
}
variable "machine_type"{
    type = string
    default = "e2-micro"
}
variable "image"{
    type = string
    default = "centos-cloud/centos-8"
}
variable "ip_forward"{
    type = bool
    default = true
}
variable "source_ranges" {
    type = list
    default = ["0.0.0.0/0"]
}


// For AWS RDS

variable "db_name"{
    type = string
    default = "wordpress"
}
variable "instance_class"{
    type = string
    default = "db.t2.micro"
}
variable "engine"{
    type = string
    default = "mysql"
}
variable "db_username"{
type = string
default = "kaneki"
}
variable "db_passwd" {
type = string
default = "TERRAFORMmulticloud2021"
}
