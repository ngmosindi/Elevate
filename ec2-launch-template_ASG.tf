resource "aws_launch_template" "my_lt" {
  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data     = filebase64("install_apache.sh")
} 

resource "aws_autoscaling_group" "my_asg" {
  min_size            = 1
  max_size            = 3
  availability_zones  = ["us-west-2"]
  desired_capacity    = 2
  launch_template {
    id      = aws_launch_template.my_lt.id
    version = aws_launch_template.my_lt.latest_version
  }
}