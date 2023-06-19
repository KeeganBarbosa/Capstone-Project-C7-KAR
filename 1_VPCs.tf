# Create the three VPCs
resource "aws_vpc" "non_production_vpc" {
  cidr_block = "172.12.0.0/20"
  tags = {
    terraform = "true"
    Name = "Non Production VPC"
  }
}

resource "aws_vpc" "on_premises_vpc" {
  cidr_block = "172.16.1.0/27"
  tags = {
    terraform = "true"
    Name = "On Premises VPC"
  }
}

resource "aws_vpc" "production_vpc" {
  cidr_block = "172.20.0.0/20"
  tags = {
    terraform = "true"
    Name = "Production VPC"
  }
}

#Create the internet gateways

resource "aws_internet_gateway" "non_production_ig" {
  vpc_id = aws_vpc.non_production_vpc.id
  tags = {
    Name        = "non_production_vpc-igw"
  }
}

resource "aws_internet_gateway" "production_ig" {
  vpc_id = aws_vpc.production_vpc.id
  tags = {
    Name        = "production_vpc-igw"
  }
}

resource "aws_internet_gateway" "on_premises_ig" {
  vpc_id = aws_vpc.on_premises_vpc.id
  tags = {
    Name        = "on_premises_vpc-igw"
  }
}