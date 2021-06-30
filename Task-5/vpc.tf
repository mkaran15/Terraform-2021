resource "aws_vpc" "lwterra" {
  cidr_block       = "10.0.0.0/24"
  tags = {
    Name = "lwterra"
  }
}

resource "aws_subnet" "frontend" {
  vpc_id     = aws_vpc.lwterra.id
  cidr_block = "10.0.0.0/27"
  tags = {
    Name = "Frontend"
  }
}


resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.lwterra.id
  tags = {
    Name = "gateway to connect"
  }
}


resource "aws_route_table" "public_route_table" {   
    vpc_id =  aws_vpc.lwterra.id
    route {
   	cidr_block = "0.0.0.0/0"               
	gateway_id = aws_internet_gateway.internet_gw.id
     }
 }

resource "aws_route_table_association" "association" {
    subnet_id = aws_subnet.frontend.id
    route_table_id = aws_route_table.public_route_table.id
 }
