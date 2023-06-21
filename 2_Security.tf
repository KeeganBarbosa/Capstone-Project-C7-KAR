#North American IP

data "aws_ip_ranges" "america_ec2" {
  regions  = ["us-east-1", "us-west-1","us-east-2", "us-west-2"]
  services = ["ec2"]
}


#Security Group Construction

resource "aws_security_group" "non_production_security_group" {
  name   = "My non-production security group"
  vpc_id = aws_vpc.non_production_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


      ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name        = "Non Production Security Policy"
  }
}

resource "aws_security_group" "on_premises_security_group" {
  name   = "My on premises security group"
  vpc_id = aws_vpc.on_premises_vpc.id

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.12.0.0/20"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.20.0.0/20"]
  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


      ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name        = "On Premises Security Policy"
  }
}

resource "aws_security_group" "production_security_group" {
  name   = "My production security group"
  vpc_id = aws_vpc.production_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.16.1.0/27"]
  }

    egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.20.0.0/20"]
  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = data.aws_ip_ranges.america_ec2.cidr_blocks
  }


    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = data.aws_ip_ranges.america_ec2.cidr_blocks
  }


    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = data.aws_ip_ranges.america_ec2.cidr_blocks
  }

    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = data.aws_ip_ranges.america_ec2.cidr_blocks
  }

      ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = data.aws_ip_ranges.america_ec2.cidr_blocks
  }


    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = data.aws_ip_ranges.america_ec2.cidr_blocks
  }


    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = data.aws_ip_ranges.america_ec2.cidr_blocks
  }

    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = data.aws_ip_ranges.america_ec2.cidr_blocks
  }








  tags = {
    Name        = "Production Security Policy"
  }
}


resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits = 4096

}


resource "aws_key_pair" "non_prod_key" {
  key_name = "mynonprodkey"
  public_key = tls_private_key.rsa.public_key_openssh
  tags ={Name = "Non-Production Keys" }
}


resource "aws_key_pair" "presentation_layer_key" {
  key_name = "mypreskey"
  public_key = tls_private_key.rsa.public_key_openssh
  tags ={Name = "Production Layer Key" }
}

resource "aws_key_pair" "application_layer_key" {
  key_name = "myappkey"
  public_key = tls_private_key.rsa.public_key_openssh
  tags ={Name = "Application Layer Key" }
}