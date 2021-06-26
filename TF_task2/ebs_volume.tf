resource "aws_ebs_volume" "task2_ebs_volume" {
  depends_on = [aws_instance.task2_instance]
  availability_zone = aws_instance.task2_instance.availability_zone
  size              = 1

  tags = {
    Name = "EBS volume to attach"
  }
}