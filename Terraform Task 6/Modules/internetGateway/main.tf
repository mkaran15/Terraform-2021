resource "aws_internet_gateway" "internet_gw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.ig_name}"
  }
}


resource "aws_route_table" "public_route_table" {   
    vpc_id =  var.vpc_id
    route {
   	cidr_block = var.route_cidr_block               
	  gateway_id = aws_internet_gateway.internet_gw.id
     }
 }

resource "aws_route_table_association" "association" {
    subnet_id = var.subnet_id
    route_table_id = aws_route_table.public_route_table.id
 }
