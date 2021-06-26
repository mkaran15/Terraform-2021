resource "aws_instance" "task2_instance" {
  depends_on = [aws_security_group.task2_sg]
  ami           = "ami-06a0b4e3b7eb7a300"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.task2_sg.id}"]
  tags = {
    Name ="Task-2 Terraform"
  }
}