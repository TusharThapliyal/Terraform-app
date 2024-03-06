#tg
resource "aws_lb_target_group" "main_tg" {
  name     = "main-tg"
  port     = 80
  protocol = "http"
  vpc_id   = var.vpc_id
  tags = {
    Name = "main_tg"
  }
}
#tg attach to instance 
resource "aws_lb_target_group_attachment" "main_tg_attach" {
  target_group_arn = aws_lb_target_group.main_tg.arn
  target_id        = var.instance_id
  port             = 80
}
#alb
resource "aws_lb" "main_alb" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_alb]
  subnets            = [var.public_subnet_id, var.private_subnet_id]

  tags = {
    Name = "main_alb"
  }
}
#listner rule
resource "aws_lb_listener" "main_alb_listner" {
  load_balancer_arn = aws_lb.main_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_tg.arn
  }

  tags = {
    Name = "alb_listner_rules"
  }
}
