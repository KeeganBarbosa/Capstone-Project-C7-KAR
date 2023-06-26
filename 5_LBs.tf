resource "aws_lb" "nlb" {
  name               = "my-nlb"
  internal           = false  # Set to true if the NLB is internal
  load_balancer_type = "network"
  subnets            = [aws_subnet.presentation_layer_public_subnet1.id,aws_subnet.presentation_layer_public_subnet2.id]  # Replace with the actual subnet IDs [for subnet in aws_vpc.production_vpc : subnet.id]

  enable_cross_zone_load_balancing = true  # Optional: Enable cross-zone load balancing

  tags          = {
    Name        = "Network Load Balancer"
  }

}


resource "aws_lb_target_group" "nlb_target" {
  name     = "nlb-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.production_vpc.id
  target_type = "instance" 
}


resource "aws_lb_target_group_attachment" "nlb_target_attachment1" {
  target_group_arn = aws_lb_target_group.nlb_target.arn
  target_id        = aws_instance.presentation_instance1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "nlb_target_attachment2" {
  target_group_arn = aws_lb_target_group.nlb_target.arn
  target_id        = aws_instance.presentation_instance2.id
  port             = 80
}


resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn

  port              = 80
  protocol          = "TCP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target.arn
  }
}




resource "aws_lb" "alb" {
 name               = "my-alb"
 internal           = false  # Set to true if the NLB is internal
 load_balancer_type = "application"
 subnets            =   [aws_subnet.application_layer_subnet1.id,aws_subnet.application_layer_subnet2.id]# Replace with the actual subnet IDs

 enable_cross_zone_load_balancing = true  # Optional: Enable cross-zone load balancing

  tags        = {
  Name        = "Application Load Balancer"
  }

}


resource "aws_lb_target_group" "alb_target" {
 name     = "alb-tg"
 port     = 80
 protocol = "HTTP"
vpc_id   = aws_vpc.production_vpc.id
}


resource "aws_lb_target_group_attachment" "alb_target_attachment1" {
  target_group_arn = aws_lb_target_group.alb_target.arn
  target_id        = aws_instance.application_instance1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb_target_attachment2" {
  target_group_arn = aws_lb_target_group.alb_target.arn
  target_id        = aws_instance.application_instance2.id
  port             = 80
}




resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn

  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}