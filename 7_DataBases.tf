# Database Subnet Groups


resource "aws_db_subnet_group" "db_group" {
  name       = "db_group_1"
  subnet_ids = ["${aws_subnet.database_layer_subnet1.id}", "${aws_subnet.database_layer_subnet2.id}" ]

  tags = {
    Name = "DB Group"
  }
}



#Databases 

resource "aws_db_instance" "database" {
  identifier             = "database"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "MySQL"
  username               = "test"
  password               = "SorryThisIsSoLongCapstoneTeam!"
  db_subnet_group_name   = aws_db_subnet_group.db_group.name
  vpc_security_group_ids = [aws_security_group.production_security_group.id]
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags                    = {
    Name                  = "MySQL Database"
  }
}

