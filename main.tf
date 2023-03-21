# Read in the VPC CIDR block and subnet CIDR blocks from a configuration file
#locals {
#  config = jsondecode(file("config.json"))

#  vpc_cidr_block = local.config.vpc_cidr_block
#  public_subnet_cidr_block = local.config.public_subnet_cidr_block
#  private_subnet_cidr_block = local.config.private_subnet_cidr_block
#}

# Set the region to deploy to
provider "aws" {
  region = "us-east-1"
}
#Create MIRA VPC 
module "vpc" {
  source = "./vpc"
  vpc_name = "mira_vpc"
  #enable_dns_hostname=true
  vpc_cidr_block="192.168.0.0/16"
}
module "public_subnet" {
  source = "./subnet"
  subnet_name = "mira_public_subnet"
  vpc_id = module.vpc.id
  cidr_block="192.168.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

module "private_subnet" {
  source = "./subnet"
  subnet_name = "mira_private_subnet"
  vpc_id = module.vpc.id
  cidr_block="192.168.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

# Create the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = module.vpc.id
  tags = {
    Name = "mira_igw"
  }
}
# Create the route table and associate it with the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = module.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id = module.public_subnet.subnet_id
  route_table_id = aws_route_table.public_route_table.id
}
# Create the EC2 instance and associate it with the private subnet
module "instance" {
  source = "./instance"
  instance_name = "coolpipe"
  ec2_count     = 1
  ami_id        = "ami-0557a15b87f6559cf"
 # instance_type = "t3.large"
  instance_type = "t2.micro" 
  subnet_id = module.private_subnet.subnet_id
}

# Data source to get the availability zones for the region
data "aws_availability_zones" "available" {}
