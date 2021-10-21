provider "aws" {
  region = "us-west-2"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2"

  tags = {
    Name = "my_subnet"
  }
}

resource "aws_network_interface" "foo" {
  subnet_id = aws_subnet.my_subnet.id

  tags = {
    Name = "primary_network_interface"
  }
}

locals {
  web_instance_type_map = {
    stage = "t1.micro"
    prod  = "t2.micro"
  }

  web_instance_count_map = {
    stage = 1
    prod  = 2
  }

  backend_instances = {
    "t1.micro" = data.aws_ami.ubuntu.id
    "t2.micro" = data.aws_ami.ubuntu.id
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.web_instance_type_map[terraform.workspace]
  count         = local.web_instance_count_map[terraform.workspace]

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "backend" {
  for_each = local.backend_instances

  ami           = each.value
  instance_type = each.key
}