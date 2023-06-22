#Elastic IPs


resource "aws_eip" "non_prod_NAT_eip" {
  vpc   = true
}

resource "aws_eip" "prod_NAT_eip" {
  vpc   = true
}

resource "aws_eip" "on_prem_NAT_eip" {
  vpc   = true
}


#NATs

resource "aws_nat_gateway" "non_prod_NAT" {
  subnet_id     = aws_subnet.non_production_subnet6.id
  allocation_id = aws_eip.non_prod_NAT_eip.id
}

resource "aws_nat_gateway" "prod_NAT" {
  subnet_id     = aws_subnet.presentation_layer_public_subnet1.id
  allocation_id = aws_eip.prod_NAT_eip.id
}

resource "aws_nat_gateway" "on_prem_NAT" {
  subnet_id     = aws_subnet.on_premises_public_subnet.id
  allocation_id = aws_eip.on_prem_NAT_eip.id
}