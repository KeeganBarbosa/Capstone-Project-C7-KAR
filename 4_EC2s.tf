# Create EC2 Instance on prem

resource "aws_instance" "on_premises_instance" {
  ami           = "ami-022e1a32d3f742bd8"  # Replace with your desired AMI ID
  instance_type = "t3.micro"  # Replace with your desired instance type
  key_name      = "testpair"
  subnet_id     = aws_subnet.on_premises_private_subnet.id

 vpc_security_group_ids = [aws_security_group.on_premises_security_group.id]  


  tags = {
    Name        = "On Premises Instance"
  }
}


# Create EC2 Instance production

resource "aws_instance" "presentation_instance1" {
  ami           = "ami-022e1a32d3f742bd8"  # Replace with your desired AMI ID
  instance_type = "t3.micro"  # Replace with your desired instance type
  key_name = aws_key_pair.presentation_layer_key.key_name
  subnet_id     =  aws_subnet.presentation_layer_public_subnet1.id

   vpc_security_group_ids = [aws_security_group.production_security_group.id]  


  tags = {
    Name        = "Presentation Layer Instance 1"
  }
}

resource "aws_instance" "presentation_instance2" {
  ami           = "ami-022e1a32d3f742bd8"  # Replace with your desired AMI ID
  instance_type = "t3.micro"  # Replace with your desired instance type
  key_name = aws_key_pair.presentation_layer_key.key_name
  subnet_id     =  aws_subnet.presentation_layer_public_subnet2.id

   vpc_security_group_ids = [aws_security_group.production_security_group.id]  

  tags = {
    Name        = "Presentation Layer Instance 2"
  }
}


resource "aws_instance" "application_instance1" {
  ami           = "ami-022e1a32d3f742bd8"  # Replace with your desired AMI ID
  instance_type = "t3.micro"  # Replace with your desired instance type
  key_name = aws_key_pair.application_layer_key.key_name
  subnet_id     =  aws_subnet.application_layer_subnet1.id

  vpc_security_group_ids = [aws_security_group.production_security_group.id]  


  tags = {
   Name        = "Application Layer Instance 1"
 }
}


resource "aws_instance" "application_instance2" {
 ami           = "ami-022e1a32d3f742bd8"  # Replace with your desired AMI ID
  instance_type = "t3.micro"  # Replace with your desired instance type
  key_name = aws_key_pair.application_layer_key.key_name
  subnet_id     =  aws_subnet.application_layer_subnet2.id
  
  vpc_security_group_ids = [aws_security_group.production_security_group.id]  

  tags = {
   Name        = "Application Layer Instance 2"
  }
}

#Create EC2 Instance non-production


# resource "aws_instance" "non_production_instance1" {
#   ami           = "ami-090e0fc566929d98b"  # Replace with your desired AMI ID
#   instance_type = "t3.micro"  # Replace with your desired instance type
#   subnet_id     =  aws_subnet.non_production_subnet1.id
#   key_name = aws_key_pair.non_prod_key.key_name


#  vpc_security_group_ids = [aws_security_group.non_production_security_group.id]  
#   tags = {
#     Name        = "Tesla Instance"
#   }
# }

# resource "aws_instance" "non_production_instance2" {
#   ami           = "ami-022e1a32d3f742bd8"  # Replace with your desired AMI ID
#   instance_type = "t3.micro"  # Replace with your desired instance type
#   key_name = aws_key_pair.non_prod_key.key_name
#   subnet_id     =  aws_subnet.non_production_subnet2.id

#  vpc_security_group_ids = [aws_security_group.non_production_security_group.id] 

#   tags = {
#     Name        = "Toyota Instance"
#   }
# }


# resource "aws_instance" "non_production_instance3" {
#   ami           = "ami-0261755bbcb8c4a84"  # Replace with your desired AMI ID
#   instance_type = "t3.micro"  # Replace with your desired instance type
#   key_name = aws_key_pair.non_prod_key.key_name
#   subnet_id     =  aws_subnet.non_production_subnet3.id

#  vpc_security_group_ids = [aws_security_group.non_production_security_group.id] 
  

#   tags = {
#     Name        = "Ford Instance"
#   }
# }


# resource "aws_instance" "non_production_instance4" {
#   ami           = "ami-0cabbd189b4f82aa0"  # Replace with your desired AMI ID
#   instance_type = "t3.micro"  # Replace with your desired instance type
#   key_name = aws_key_pair.non_prod_key.key_name
#   subnet_id     =  aws_subnet.non_production_subnet4.id

#  vpc_security_group_ids = [aws_security_group.non_production_security_group.id] 
  

#   tags = {
#     Name        = "Jeep Instance"
#   }
# }


# resource "aws_instance" "non_production_instance5" {
#   ami           = "ami-021b67c90e3e68a8f"  # Replace with your desired AMI ID
#   instance_type = "t3.micro"  # Replace with your desired instance type
#   key_name = aws_key_pair.non_prod_key.key_name
#   subnet_id     =  aws_subnet.non_production_subnet5.id

#  vpc_security_group_ids = [aws_security_group.non_production_security_group.id] 
  

#   tags = {
#     Name        = "Honda Instance"
#   }
# }


#Customer Gateway

resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65000
  ip_address = "203.0.113.1"
  type       = "ipsec.1"

  tags = {
    Name = "KAR Customer Gateway"
  }
}


