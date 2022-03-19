resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  vpc_id      = aws_vpc.myvpc.id
  ingress {
   from_port   = "8080"
   to_port     = "80"
   protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Web Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow inbound traffic from alb"
  vpc_id      = aws_vpc.myvpc.id
  ingress  {
   from_port   = "80" 
   to_port     = "80"
   cidr_blocks = ["10.0.0.0/16"]
   protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
}
}
# Create Application Security Group
resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  vpc_id      = aws_vpc.myvpc.id
  ingress  {
    security_groups = [aws_security_group.web_sg.id]
    from_port       = "80"
    to_port         = "80"
    protocol        = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    tags = {
      Name = "app_sg"
  }
}
}
#Create Database Security Group
resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Allow inbound traffic from application layer"
  vpc_id      = aws_vpc.myvpc.id
  ingress {
       from_port       = "3306"
       to_port         = "3306"
       protocol        = "tcp"
       security_groups = [aws_security_group.app_sg.id]
       tags = {
          Name = "Database-SG"
  }
}
}