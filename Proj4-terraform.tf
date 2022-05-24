//vpc
resource "aws_vpc" "Proj4-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Proj4-vpc"
  }
}
//private subnet 1
resource "aws_subnet" "Proj4-subnet-prv1" {
  vpc_id     = aws_vpc.Proj4-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Proj4-subnet-prv1"
  }
}
//private subnet 2
resource "aws_subnet" "Proj4-subnet-prv2" {
  vpc_id     = aws_vpc.Proj4-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Proj4-subnet-prv2"
  }
}
//public subnet 1
resource "aws_subnet" "Proj4-subnet-pub1" {
  vpc_id     = aws_vpc.Proj4-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Proj4-subnet-pub1"
  }
}
//public subnet 2
resource "aws_subnet" "Proj4-subnet-pub2" {
  vpc_id     = aws_vpc.Proj4-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Proj4-subnet-pub2"
  }
}

//public route table
resource "aws_route_table" "Proj4-rt-pub" {
  vpc_id = aws_vpc.Proj4-vpc.id

  tags = {
    Name = "Proj4-rt-pub"
  }
}

//private route table
resource "aws_route_table" "Proj4-rt-prv" {
  vpc_id = aws_vpc.Proj4-vpc.id

  tags = {
    Name = "Proj4-rt-prv"
  }
}

//Public route table association with public subnet 1
resource "aws_route_table_association" "Proj4-PubRT-association1" {
  subnet_id      = aws_subnet.Proj4-subnet-pub1.id
  route_table_id = aws_route_table.Proj4-rt-pub.id
}

//Public route table association with public subnet 2
resource "aws_route_table_association" "Proj4-PubRT-association2" {
  subnet_id      = aws_subnet.Proj4-subnet-pub2.id
  route_table_id = aws_route_table.Proj4-rt-pub.id
}

//Private route table association with private subnet 1
resource "aws_route_table_association" "Proj4-PrvRT-association1" {
  subnet_id      = aws_subnet.Proj4-subnet-prv1.id
  route_table_id = aws_route_table.Proj4-rt-prv.id
}

//Private route table association with private subnet 2
resource "aws_route_table_association" "Proj4-PrvRT-association2" {
  subnet_id      = aws_subnet.Proj4-subnet-prv2.id
  route_table_id = aws_route_table.Proj4-rt-prv.id
}

// internet gateway
resource "aws_internet_gateway" "Proj4-igw" {
  vpc_id = aws_vpc.Proj4-vpc.id

  tags = {
    Name = "Proj4-igw"
  }
}

//internet gateway route
resource "aws_route" "Proj4-internet-route" {
  route_table_id            = aws_route_table.Proj4-rt-pub.id
  gateway_id                = aws_internet_gateway.Proj4-igw.id
  destination_cidr_block    = "0.0.0.0/0"
}
