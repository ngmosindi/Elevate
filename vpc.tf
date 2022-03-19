# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block       = var.cidr_block
  tags = {
    Name = "Elevate_VPC"
}
}
