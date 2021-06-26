resource "aws_instance" "wordpress" {
  ami = "ami-06a0b4e3b7eb7a300"
  instance_type = "t2.micro"
  key_name = "task3"
  security_groups = ["Security Group"]
  tags = {
    Name ="Task-2 Terraform"
  }
}

resource "null_resource" "host_wordpress" {
  connection{
    type = "ssh"
    user = "ec2-user"
    private_key = file("C:/Users/karan.maheshwari/Downloads/task3.pem")
    host = aws_instance.wordpress.public_ip

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



output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
} 