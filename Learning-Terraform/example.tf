variable "access_key" {
  type = "string"
  description = "The access key of the Terraform IAM user that was setup with administrator access"
}

variable "secret_key" {
  type = "string"
  description = "The secret key of the Terraform IAM user that was setup with administrator access"
}

variable "region" {
  type = "string"
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  tags = {
    Name = "TF Example Analysis Instance"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}
