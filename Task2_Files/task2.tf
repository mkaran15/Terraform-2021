resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "task2_sg" {
  name        = "allow_HTTP"
  description = "Allow HTTP inbound traffic"


  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_default_vpc.default.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_instance" "task2_instance" {
  ami           = "ami-06a0b4e3b7eb7a300"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.task2_sg.id}"]
  tags = {
    Name ="Task-2 Terraform"
  }
}
resource "aws_ebs_volume" "task2_ebs_volume" {
  availability_zone = aws_instance.task2_instance.availability_zone
  size              = 1

  tags = {
    Name = "EBS volume to attach"
  }
}
resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.task2_ebs_volume.id
  instance_id = aws_instance.task2_instance.id
}

