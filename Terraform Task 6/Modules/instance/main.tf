resource "aws_instance" "test-instance" {
  
  count                  = var.no_of_nodes
  ami                    = var.ami_id
  instance_type          = var.instance_type[count.index]
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  availability_zone      = var.availability_zone
  vpc_security_group_ids = var.vpc_security_group_ids


  tags = {
    Name = "${var.instance_tag_name}"
    Project = "${var.instance_tag_project}"
  }
}

output "instance-id"{
    value = "${aws_instance.test-instance.*.id}"
}

output "instance-public-ip"{
    value = "${aws_instance.test-instance.*.public_ip}"
}
