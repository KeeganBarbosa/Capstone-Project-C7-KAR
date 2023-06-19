resource "aws_lb" "nlb" {
  name               = "my-nlb"
  internal           = false  # Set to true if the NLB is internal
  load_balancer_type = "network"
  subnets            = ["presentation_layer_public_subnet1", "presentation_layer_public_subnet2"]  # Replace with the actual subnet IDs

  enable_cross_zone_load_balancing = true  # Optional: Enable cross-zone load balancing

}


resource "aws_lb_target_group" "nlb_target" {
  name     = "nlb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "aws_vpc.production_vpc.id"
}


resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn

  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target.arn
  }
}




resource "aws_lb" "alb" {
  name               = "my-alb"
  internal           = false  # Set to true if the NLB is internal
  load_balancer_type = "application"
  subnets            = ["application_layer_subnet1", "application_layer_public_subnet2"]  # Replace with the actual subnet IDs

  enable_cross_zone_load_balancing = true  # Optional: Enable cross-zone load balancing

}


resource "aws_lb_target_group" "alb_target" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "aws_vpc.production_vpc.id"
}


resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.nlb.arn

  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}