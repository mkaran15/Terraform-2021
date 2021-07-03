resource "aws_instance" "ec2-instance" {
  depends_on = [aws_vpc.lwterra]
  ami = "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"
  key_name = "terraform_task-5"
  subnet_id       = aws_subnet.frontend.id
  vpc_security_group_ids = [aws_security_group.task2_sg.id]
  associate_public_ip_address = true
  tags = {
    Name ="Task-5 Terraform"
  }
}

resource "aws_ebs_volume" "hard_disk" {
  availability_zone = aws_instance.ec2-instance.availability_zone
  size              = 1

  tags = {
    Name = "External Hard Disk"
  }
}

resource "aws_volume_attachment" "attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.hard_disk.id
  instance_id = aws_instance.ec2-instance.id
}

resource "null_resource" "my_skills" {
  connection{
    type = "ssh"
    user = "ec2-user"
    private_key = file("C:/Terraform/terraform_task-5.pem")
    host = aws_instance.ec2-instance.public_ip

}
  provisioner "remote-exec" {
    inline = [
		"sudo yum install httpd wget unzip -y",
		"sudo wget https://github.com/mkaran15/skills/archive/refs/heads/main.zip",
		"sudo unzip main.zip",
		"sudo mv skills-main/* /var/www/html/",
		"sudo setenforce 0",
		"sudo systemctl start httpd"
		
	    ]
  }
}


output "instance_public_ip" {
  value = aws_instance.ec2-instance.public_ip
} 