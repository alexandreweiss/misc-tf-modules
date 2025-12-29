data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = var.ubuntu_ami_owners
  filter {
    name   = "name"
    values = [var.ubuntu_ami_name_pattern]
  }
}

module "ec2_instance_linux" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = local.vm.vm_name

  ami                         = data.aws_ami.ubuntu.image_id
  instance_type               = var.vm_size
  user_data                   = var.user_data != "dummy" ? var.user_data : null
  key_name                    = var.key_name
  monitoring                  = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.allow_all_rfc1918.id]
  associate_public_ip_address = false

  tags = {
    Cloud       = "AWS"
    Application = "Dev Server"
  }
}

resource "aws_security_group" "allow_all_rfc1918" {
  name        = "allow_all_rfc1918_vpc"
  description = "allow_all_rfc1918_vpc"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_all_rfc1918_vpc"
  }
}

resource "aws_security_group" "allow_web_ssh_public" {
  name        = "allow_web_ssh_public"
  description = "allow_web_ssh_public"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_web_ssh_public"
  }
}
