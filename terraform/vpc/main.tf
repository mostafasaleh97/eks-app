resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc-cidr
  tags = {
     Name = var.vpc-name
  }
}
resource "aws_subnet" "public-subnet" {

  vpc_id     = aws_vpc.myvpc.id
  count = length(var.public-subnet-names)
  availability_zone = var.public-availability_zone[count.index]
  map_public_ip_on_launch = true
  cidr_block = var.public-subnet-cidr[count.index]
  tags = {
    Name = var.public-subnet-names[count.index]
    "kubernetes.io/cluster/demo" = "shared"
    "kubernetes.io/role/elb"                  = 1
}
}
resource "aws_subnet" "private-subnet" {

  vpc_id     = aws_vpc.myvpc.id
  count = length(var.private-subnet-names)
  availability_zone = var.private-availability_zone[count.index]
  cidr_block = var.private-subnet-cidr[count.index]
  tags = {
    Name = var.private-subnet-names[count.index]
    "kubernetes.io/cluster/demo" = "shared"
    "kubernetes.io/role/internal-elb"                  = 1
}
}
############# First Route ###############
resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.route-cidr
    gateway_id = aws_internet_gateway.gw.id
  }

  

  tags = {
    Name = var.route-names[0]
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet[0].id
  route_table_id = aws_route_table.publicroute.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-subnet[1].id
  route_table_id = aws_route_table.publicroute.id
}



###########SECOND ROUTE ###################
resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.route-cidr
    gateway_id = aws_nat_gateway.mynat[0].id
  }
  tags = {
    Name = var.route-names[1]
  }
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private-subnet[0].id
  route_table_id = aws_route_table.privateroute.id
}
resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private-subnet[1].id
  route_table_id = aws_route_table.privateroute.id
}


######## Elastic IP ############
resource "aws_eip" "lb" {
  vpc      = true
  count = length(var.elastic-names)
  tags = {
    "Name" = var.elastic-names[count.index]
  }
}


########### Internet Gateway ##########
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "firstgate"
  }
}


########### Nat Gataway#############
resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.lb[count.index].id 
  count = length(var.nat-names)
  subnet_id     = aws_subnet.public-subnet[0].id

  tags = {
    Name = var.nat-names[count.index]
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

