#Routing tables for tgw

resource "aws_ec2_transit_gateway_route_table" "route_table_prod" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
}


resource "aws_ec2_transit_gateway_route_table" "route_table_on_prem" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
}


resource "aws_ec2_transit_gateway_route_table" "route_table_non_prod" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
}


# Routing for tgw

resource "aws_ec2_transit_gateway_route" "route_a_to_b" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.route_table_prod.id
  destination_cidr_block         = "172.16.1.0/27"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.on_premises_attachment.id
}

resource "aws_ec2_transit_gateway_route" "route_b_to_c" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.route_table_on_prem.id
  destination_cidr_block         ="172.12.0.0/20"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.non_production_attachment.id
}



# Create a non production route table
resource "aws_route_table" "non_prod_table" {
  vpc_id = aws_vpc.non_production_vpc.id

  # Route traffic to NAT gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.non_prod_NAT.id
    }
  tags={
      Name = "Non Production Table"
      }

      
  # Route traffic to on premises
  route {
    cidr_block            = "172.16.1.0/27"
    transit_gateway_id    = aws_ec2_transit_gateway.transit_gateway.id
  }
}

# Associate the route table with the non production subnets
resource "aws_route_table_association" "table_assign_non_prod1" {
  subnet_id      = aws_subnet.non_production_subnet1.id
  route_table_id = aws_route_table.non_prod_table.id
}

resource "aws_route_table_association" "table_assign_non_prod2" {
  subnet_id      = aws_subnet.non_production_subnet2.id
  route_table_id = aws_route_table.non_prod_table.id
}

resource "aws_route_table_association" "table_assign_non_prod3" {
  subnet_id      = aws_subnet.non_production_subnet3.id
  route_table_id = aws_route_table.non_prod_table.id
}

resource "aws_route_table_association" "table_assign_non_prod4" {
  subnet_id      = aws_subnet.non_production_subnet4.id
  route_table_id = aws_route_table.non_prod_table.id
}

resource "aws_route_table_association" "table_assign_non_prod5" {
  subnet_id      = aws_subnet.non_production_subnet5.id
  route_table_id = aws_route_table.non_prod_table.id
}




# Create production route tables
resource "aws_route_table" "prod_table_priv" {
  vpc_id = aws_vpc.production_vpc.id

  # Route traffic to NAT gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prod_NAT.id
    }
  tags={
      Name = "Production Table (Private)"
      }

      
  # Route traffic to on premises
  route {
    cidr_block            = "172.16.1.0/27"
    transit_gateway_id    = aws_ec2_transit_gateway.transit_gateway.id
  }
}


resource "aws_route_table" "prod_table_pub" {
  vpc_id = aws_vpc.production_vpc.id

  # Route traffic to the Internet gateway
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_internet_gateway.production_ig.id
    }
  tags={
      Name = "Production Table (Public)"
      }



      
  # Route traffic to on premises
  route {
    cidr_block            = "172.16.1.0/27"
    transit_gateway_id    = aws_ec2_transit_gateway.transit_gateway.id
  }
}









# Associate the route table with the public and private production subnets
resource "aws_route_table_association" "table_assign_prod_priv1" {
  subnet_id      = aws_subnet.application_layer_subnet1.id
  route_table_id = aws_route_table.prod_table_priv.id
}


resource "aws_route_table_association" "table_assign_prod_priv2" {
  subnet_id      = aws_subnet.application_layer_subnet2.id
  route_table_id = aws_route_table.prod_table_priv.id
}


resource "aws_route_table_association" "table_assign_prod_pub1" {
  subnet_id      = aws_subnet.presentation_layer_public_subnet1.id
  route_table_id = aws_route_table.prod_table_pub.id
}


resource "aws_route_table_association" "table_assign_prod_pub2" {
  subnet_id      = aws_subnet.presentation_layer_public_subnet2.id
  route_table_id = aws_route_table.prod_table_pub.id
}


# Create a on premises route table
resource "aws_route_table" "on_premises_table" {
  vpc_id = aws_vpc.on_premises_vpc.id

  # Route traffic to NAT gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.on_prem_NAT.id
    }
  tags={
      Name = "On Premises Table"
      }

      
  # Route traffic to on production
  route {
    cidr_block            = "172.20.0.0/20"
    transit_gateway_id    = aws_ec2_transit_gateway.transit_gateway.id
  }

  #Route traffic to non production

  route {
    cidr_block            = "172.12.0.0/20"
    transit_gateway_id    = aws_ec2_transit_gateway.transit_gateway.id
  }
}



resource "aws_route_table" "on_prem_table_pub" {
  vpc_id = aws_vpc.on_premises_vpc.id

  # Route traffic to the Internet gateway
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_internet_gateway.on_premises_ig.id
    }
  tags={
      Name = "On Prem Table (Public)"
      }



  #Route traffic to prod    
  route {
    cidr_block            = "172.20.0.0/20"
    transit_gateway_id    = aws_ec2_transit_gateway.transit_gateway.id
  }

  #Route traffic to non production

  route {
    cidr_block            = "172.12.0.0/20"
    transit_gateway_id    = aws_ec2_transit_gateway.transit_gateway.id
  }
}






# Associate the route table with the on premises subnet 
resource "aws_route_table_association" "table_assign_on_prem" {
  subnet_id      = aws_subnet.on_premises_private_subnet.id
  route_table_id = aws_route_table.on_premises_table.id
}

resource "aws_route_table_association" "table_assign_on_prem_pub" {
  subnet_id      = aws_subnet.on_premises_public_subnet.id
  route_table_id = aws_route_table.on_prem_table_pub.id
}



#Non Prod Pub
resource "aws_route_table" "non_prod_table_pub" {
  vpc_id = aws_vpc.non_production_vpc.id

  # Route traffic to the Internet gateway
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_internet_gateway.non_production_ig.id
    }
  tags={
      Name = "Non-Production Table (Public)"
      }



      
  # Route traffic to on premises
  route {
    cidr_block            = "172.16.1.0/27"
    transit_gateway_id    = aws_ec2_transit_gateway.transit_gateway.id
  }
}

resource "aws_route_table_association" "table_assign_non_prod6" {
  subnet_id      = aws_subnet.non_production_subnet6.id
  route_table_id = aws_route_table.non_prod_table_pub.id
}