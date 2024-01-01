# Create a security group for the public subnet
resource "aws_security_group" "james-twoge-public-sg" {
  name = "james-twoge-public-sg"
  description = "Security group for the public subnet"
  vpc_id = aws_vpc.james-twoge-vpc.id

  # Allow inbound traffic HTTP on port 80 and SSH on port 22
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for the private subnet
resource "aws_security_group" "james-twoge-private-sg" {
  name = "james-twoge-private-sg"
  description = "Security group for the private subnet"
  vpc_id = aws_vpc.james-twoge-vpc.id

  # Allow inbound traffic from the public subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    security_groups = [aws_security_group.james-twoge-public-sg.id]
  }

    ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}