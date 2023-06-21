# Create the private subnets for the non-production VPC
resource "aws_subnet" "non_production_subnet1" {
  vpc_id            = aws_vpc.non_production_vpc.id
  cidr_block        = "172.12.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    terraform = "true"
    Name = "Tesla Subnet"
  }
}

resource "aws_subnet" "non_production_subnet2" {
  vpc_id            = aws_vpc.non_production_vpc.id
  cidr_block        = "172.12.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    terraform = "true"
    Name = "Toyota Subnet"
  }
}

resource "aws_subnet" "non_production_subnet3" {
  vpc_id            = aws_vpc.non_production_vpc.id
  cidr_block        = "172.12.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    terraform = "true"
    Name = "Ford Subnet"
  }
}

resource "aws_subnet" "non_production_subnet4" {
  vpc_id            = aws_vpc.non_production_vpc.id
  cidr_block        = "172.12.4.0/24"
  availability_zone = "us-east-1a"
  tags = {
    terraform = "true"
    Name = "Jeep Subnet"
  }
}

resource "aws_subnet" "non_production_subnet5" {
  vpc_id            = aws_vpc.non_production_vpc.id
  cidr_block        = "172.12.5.0/24"
  availability_zone = "us-east-1a"
  tags = {
    terraform = "true"
    Name = "Honda Subnet"
  }
}

resource "aws_subnet" "non_production_subnet6" {
  vpc_id            = aws_vpc.non_production_vpc.id
  cidr_block        = "172.12.6.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    terraform = "true"
    Name = "NAT Subnet"
  }
}


# Create the subnets for the on-prem VPC

resource "aws_subnet" "on_premises_private_subnet" {
  vpc_id            = aws_vpc.on_premises_vpc.id
  cidr_block        = "172.16.1.0/28"
  availability_zone = "us-east-1a"
  tags = {
    terraform = "true"
    Name = "On Premises Private Subnet"
  }
}

resource "aws_subnet" "on_premises_public_subnet" {
  vpc_id            = aws_vpc.on_premises_vpc.id
  cidr_block        = "172.16.1.16/28"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    terraform = "true"
    Name = "Customer Gateway Subnet"
  }
}

#Create the subnets for the production environment


resource "aws_subnet" "presentation_layer_public_subnet1" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "172.20.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    terraform = "true"
    Name = "Presentation Layer 1"
  }
}


resource "aws_subnet" "application_layer_subnet1" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "172.20.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    terraform = "true"
    Name = "Application Layer 1"
  }
}

resource "aws_subnet" "database_layer_subnet1" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "172.20.5.0/24"
  availability_zone = "us-east-1a"
  tags = {
    terraform = "true"
    Name = "Database Layer 1"
  }
}



resource "aws_subnet" "presentation_layer_public_subnet2" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "172.20.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    terraform = "true"
    Name = "Presentation Layer 2"
  }
}


resource "aws_subnet" "application_layer_subnet2" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "172.20.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    terraform = "true"
    Name = "Application Layer 2"
  }
}


resource "aws_subnet" "database_layer_subnet2" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "172.20.6.0/24"
  availability_zone = "us-east-1b"
  tags = {
    terraform = "true"
    Name = "Database Layer 2"
  }
}


resource "aws_subnet" "ALB_subnet" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "172.20.7.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    terraform = "true"
    Name = "ALB Subnet"
  }
}

resource "aws_subnet" "NLB_subnet" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "172.20.8.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    terraform = "true"
    Name = "NLB Subnet"
  }
}