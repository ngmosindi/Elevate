#############################
# Security Group
#############################
resource "aws_security_group" "allow-http" {
  name        = "${var.domain}-${var.env}-allow-app-http-sg"
  description = "Allow HTTP inbound connections"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.main_vpc_cidr_block]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP Security Group"
  }
}
resource "aws_security_group" "alb_http" {
  name        = "${var.domain}-${var.env}-allow-app-alb-http-sg"
  description = "Allow HTTP traffic to instances through Application Load Balancer"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP through ALB Security Group"
  }
}
###############
# Load Balancer
############### 


resource "aws_lb" "app-alb" {
  name                  = "${var.domain}-${var.env}-app-alb"
  internal              = false
  security_groups       = [
    aws_security_group.alb_http.id
  ]
  subnets               = var.subnets

  tags = merge(
    {
      Name        = "app-ALP",
      Environment = var.env,
      Terraform   = true
    },
    var.tags
  )

}
###############
# EC2 Resource
###############
resource "aws_launch_configuration" "app" {
  name_prefix                   = "${var.domain}-${var.env}-app-"

  image_id                      = var.image_id # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type                 = var.instance_type
  key_name                      = var.key_name

  security_groups               = [ aws_security_group.allow-http.id ]
  associate_public_ip_address   = false

  user_data                     = "${file("${path.module}/install_apache.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_lb_target_group" "alb_target_group" {  
  name     = "alb-app-target-group"  
  port     = "80"  
  protocol = "HTTP"  
  vpc_id   = var.vpc_id 
  tags = {  
    Name = "alb-app-target-group"  
  }   
  stickiness {    
    type            = "lb_cookie"    
    cookie_duration = 1800    
    enabled         = true 
  }   
  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
    path                = "/"    
    port                = 80
  }
}
resource "aws_lb_listener" "alb_listener" {  
  load_balancer_arn = aws_lb.app-alb.arn
  port              = 80  
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    type             = "forward"  
  }
}


resource "aws_autoscaling_group" "app" {
  name                  = "${aws_launch_configuration.app.name}-asg"

  min_size              = 1
  desired_capacity      = 1
  max_size              = 4
  
  launch_configuration  = aws_launch_configuration.app.name
  target_group_arns     = [aws_lb_target_group.alb_target_group.arn]

  vpc_zone_identifier  = var.vpc_zone_identifier

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "app"
    propagate_at_launch = true
  }

}
resource "aws_autoscaling_attachment" "alb_autoscale" {
  lb_target_group_arn   = aws_lb_target_group.alb_target_group.arn
  autoscaling_group_name = aws_autoscaling_group.app.id
}