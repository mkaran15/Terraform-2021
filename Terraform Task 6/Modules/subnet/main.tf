resource "aws_subnet" "public-private" {
  count = var.subnet_count
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_private[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone = var.availability_zone_private[count.index]

  tags = {
    Name = "${var.subnet_name}-${count.index + 1}"
  }
}

output "subnet_id" {
  value = "${aws_subnet.public-private.*.id}"
}


