# Create the VPC
resource "aws_vpc" "james-twoge-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "james-twoge-vpc"
  }
}

# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "james-twoge-igw" {
  vpc_id = aws_vpc.james-twoge-vpc.id
  tags = {
    Name = "james-twoge-igw"
  }
}

# Create the public subnet
resource "aws_subnet" "james-twoge-public-subnet" {
  vpc_id     = aws_vpc.james-twoge-vpc.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "james-twoge-public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.james-twoge-vpc.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.james-twoge-igw.id
}

resource "aws_route_table_association" "public-rt" {
  subnet_id = aws_subnet.james-twoge-public-subnet.id
  route_table_id = aws_route_table.public.id
}

# Create the private subnet
resource "aws_subnet" "james-twoge-private-subnet" {
  vpc_id     = aws_vpc.james-twoge-vpc.id
  cidr_block = "10.0.16.0/20"
  availability_zone = "us-east-2b" 
  tags = {
    Name = "james-twoge-private-subnet"
  }
}

# Create a NAT Gateway for the private subnet
resource "aws_nat_gateway" "james-twoge-nat-gateway" {
  allocation_id = aws_eip.james-twoge-eip.id
  subnet_id = aws_subnet.james-twoge-private-subnet.id
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "james-twoge-eip" {}
