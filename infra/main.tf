
# # Create a VPC
# resource "aws_vpc" "vpc-id" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "vpc-id-terraform"
#   }
# }
# resource "aws_subnet" "public-sub-1" {
#   vpc_id     = aws_vpc.vpc-id.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "ap-south-1a"

#   tags = {
#     Name = "public-sub-1"
#   }
# }


# #INTERNET GATEWAY
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.vpc-id.id

#   tags = {
#     Name = "vpc-id"
#   }
# }
# #route table
# resource "aws_route_table" "public-rt-1" {
#   vpc_id = aws_vpc.vpc-id.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }


#   tags = {
#     Name = "public-rt-1"
#   }
# }


# # rt associate
# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.public-sub-1.id
#   route_table_id = aws_route_table.public-rt-1.id
# }


# SECURITY GROUP
resource "aws_security_group" "all" {
  name        = "all"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_2

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
 
  }

  tags = {
    Name = "all"
  }
}

# INSTANCE - 1 
resource "aws_instance" "STAGE_WEB" {
  ami                           = var.os-1
  instance_type                 = var.size-1
  subnet_id                     = var.subnet_1
  vpc_security_group_ids        = [aws_security_group.all.id]
  key_name                      = var.key-1
  associate_public_ip_address   = true
  tags                          = var.ec2-tags-1
}
# INSTANCE - 2
resource "aws_instance" "STAGE_API" {
  ami                           = var.os-2
  instance_type                 = var.size-2
  subnet_id                     = var.subnet_2
  vpc_security_group_ids        = [aws_security_group.all.id]
  key_name                      = var.key-2
  associate_public_ip_address   = true
  tags                          = var.ec2-tags-2
}



