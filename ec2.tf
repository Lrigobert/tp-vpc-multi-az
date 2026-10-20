data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_1.id
  key_name      = "tp-ec2-key"
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = { Name = "Bastion-Web" }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_1.id
  key_name      = "tp-ec2-key"
  vpc_security_group_ids = [aws_security_group.app.id]

  tags = { Name = "App-Server" }
}
