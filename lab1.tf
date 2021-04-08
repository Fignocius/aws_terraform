terraform {
    required_providers{
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

# Configure the AWS Provider
provider "aws" {
    region = "us-east-2"
    access_key = <access_key>    
    secret_key = <secret_key>
}

# Configure security group 
resource "aws_security_group" "allow_http_ssh" {
    name = "allow_http_ssh"
    description = "Allow access"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
} 

# Configure resources
resource "aws_instance" "aws_machine_1" {
    ami = "ami-09558250a3419e7d0"
    instance_type = "t2.micro"
}

resource "aws_instance" "aws_machine_3" {
    ami = "ami-09558250a3419e7d0"
    instance_type = "t2.micro"
}

resource "aws_instance" "aws_machine_2" {
    ami = "ami-09558250a3419e7d0"
    instance_type = "t2.micro"
    user_data = file("user_data.sh")
    vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
}
