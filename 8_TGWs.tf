# Create the transit gateway and attach the VPCs
resource "aws_ec2_transit_gateway" "transit_gateway" {
  description = "Transit Gateway"
  tags = {
    terraform = "true"
    Name = "Transit Gateway"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "non_production_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.non_production_vpc.id
  subnet_ids         = [aws_subnet.non_production_subnet1.id
                       ]

  tags = {
    terraform = "true"
    Name = "Non Production tgw attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "on_premises_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.on_premises_vpc.id
  subnet_ids          =  [aws_subnet.on_premises_private_subnet.id
                        ]

  tags = {
    terraform = "true"
    Name = "On Premises tgw attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "production_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.production_vpc.id
  subnet_ids          =  [aws_subnet.presentation_layer_public_subnet1.id,
                          aws_subnet.presentation_layer_public_subnet2.id
                          ]

  tags = {
    terraform = "true"
    Name = "Production tgw attachment"
  }
}