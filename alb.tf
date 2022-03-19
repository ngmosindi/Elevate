#Create Application Load Balancer
resource "aws_alb"  "external_alb" {
  load_balancer_type = "application"
  subnets            = [aws_subnet.alb_subnet.id]
  security_groups    = [aws_security_group.alb_sg.id]
}

 resource "aws_lb_listener" "external_alb"  {
      load_balancer_arn = aws_lb.external_alb.arn
      port               = "80"
      protocol           = "HTTP"
  }

 resource "aws_lb_target_group" "external_alb" {
      name             = "alb_TG"
      protocol = "HTTP"
      port     = "80"
      target_type      = "instance"
      vpc_id   = aws_vpc.myvpc.id
      tags = {
        Environment = "dev"
  }
 }
