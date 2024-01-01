# Create an webserver instance in the public subnet
resource "aws_instance" "james-twoge-webserver" {
  ami           = data.aws_ami.ubuntu-ami-latest
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.james-twoge-public-subnet.id
  security_groups = [ "${aws_security_group.james-twoge-public-sg.id}" ]
  key_name = "cpdevopsew-us-east-2"
  private_ip = "10.0.0.10"

  tags = {
    Name = "twoge-webserver"
    Function = "webserver"
  }
}

# Create an database server instance in the public subnet
resource "aws_instance" "james-twoge-mysql-db" {
  ami           = data.aws_ami.ubuntu-ami-latest
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.james-twoge-public-subnet.id
  security_groups = [ "${aws_security_group.james-twoge-public-sg.id}" ]
  key_name = "cpdevopsew-us-east-2"
  private_ip = "10.0.16.10"

  tags = {
    Name = "mysql-db"
    Function = "database"
  }
}