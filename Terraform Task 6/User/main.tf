// Provider

provider "aws" {
    region                  = "ap-south-1"
    shared_credentials_file = "C:/Users/Karan Maheshwari/.aws/credentials"
    profile                 = "aws_cred"
}


// To create VPC

module "test-vpc" {
  source           = "../Modules/vpc"
  vpc_name         = "module-vpc"
  vpc_cidr         = "10.0.0.0/16"
  instance_tenancy = "default"
  
}


// To create Public Subnet 

module "public-subnet" {
  source = "../Modules/subnet"
  subnet_count = length(var.public_subnet_cidr)
  vpc_id     = module.test-vpc.aws_vpc_id
  subnet_cidr_private = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone_private = var.availability_zone_public
  subnet_name = var.public_subnet_name
}


// Internet Gateway to let outside world connect 

module "Public-Access"{
  source = "../Modules/internetGateway"

  vpc_id           = module.test-vpc.aws_vpc_id
  ig_name          = "internetGatewayToPublic"
  route_cidr_block = "0.0.0.0/0"
  subnet_id        = module.public-subnet.subnet_id[0]
}

// Security group to allow SSH and HTTP protocol

resource "aws_security_group" "sg_instance" {
  name        = "Allow_SSH_HTTP"
  description = "To allow HTTP and SSH traffic"
  vpc_id      = module.test-vpc.aws_vpc_id
  

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "allow_http_ssh"
  }
}



// Launch EC2 instance to use as a WEB Server


module "ec2"{
  source = "../Modules/instance"
  no_of_nodes          = length(var.instance_type_list)
  ami_id               = "ami-06a0b4e3b7eb7a300"
  instance_type        = var.instance_type_list
  key_name             = "terraform"
  subnet_id            = module.public-subnet.subnet_id[0]
  instance_tag_name    = "karan-test-module"
  instance_tag_project = "Task-6"
  availability_zone    = "ap-south-1a"
  vpc_security_group_ids = [aws_security_group.sg_instance.id]
 }


// To install wordpress and launch web server

resource "null_resource" "host_wordpress" {
  connection{
    type = "ssh"
    user = "ec2-user"
    private_key = file("C:/Terraform/terraform.pem")
    host = "${module.ec2.instance-public-ip[0]}"

}
  provisioner "remote-exec" {
    inline = [
		"sudo yum install httpd php php-mysqlnd php-json wget -y", 
		"sudo wget https://wordpress.org/latest.tar.gz",
		"tar -xzvf latest.tar.gz",
		"sudo mv wordpress/* /var/www/html/",
		"sudo chown -R apache.apache /var/www/html",
		"sudo setenforce 0",
		"sudo systemctl start httpd"
		
	    ]
  }
}