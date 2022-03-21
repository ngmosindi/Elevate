#############################
# Main VPC
#############################
resource "aws_vpc" "main_vpc" {
  cidr_block = var.main_vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "${var.domain}-${var.env}-main-vpc"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.domain}-${var.env}-main-igw"
  }
}

resource "aws_subnet" "main_subnet_elb_1a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.main_subnet_elb_1a_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.domain}-${var.env}-main-elb-public-1a"
    SubnetType = "Utility"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_subnet" "main_subnet_elb_1b" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.main_subnet_elb_1b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.domain}-${var.env}-main-elb-public-1b"
    SubnetType = "Utility"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_subnet" "main_subnet_web_1a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.main_subnet_web_1a_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.domain}-${var.env}-main-web-private-1a"
    SubnetType = "Private"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_subnet" "main_subnet_web_1b" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.main_subnet_web_1b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.domain}-${var.env}-main-web-private-1b"
    SubnetType = "Private"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "main_subnet_app_1a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.main_subnet_app_1a_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.domain}-${var.env}-main-app-private-1a"
    SubnetType = "Private"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_subnet" "main_subnet_app_1b" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.main_subnet_app_1b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.domain}-${var.env}-main-app-private-1b"
    SubnetType = "Private"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "main_subnet_db_1a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.main_subnet_db_1a_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.domain}-${var.env}-main-db-private-1a"
  }
}

resource "aws_subnet" "main_subnet_db_1b" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.main_subnet_db_1b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.domain}-${var.env}-main-db-private-1b"
  }
}


resource "aws_db_subnet_group" "main_subnet_db_group" {
  name = "main-subnet-db-group"
  subnet_ids = [ "${aws_subnet.main_subnet_db_1a.id}","${aws_subnet.main_subnet_db_1b.id}"]
  tags = {
    Name = "${var.domain}-${var.env}-main-subnet-db-group"
  }
}

resource "aws_eip" "main_ngw_eip" {
  vpc = true

  tags = {
    Name = "${var.domain}-${var.env}-main-ngw-eip"
  }
}

resource "aws_nat_gateway" "main_nwg" {
  allocation_id = aws_eip.main_ngw_eip.id
  subnet_id = aws_subnet.main_subnet_elb_1a.id

  tags = {
    Name = "${var.domain}-${var.env}-main-ngw"
  }
}

#############################
# Route Tables
#############################

resource "aws_route_table" "main_rt_public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "${var.domain}-${var.env}-main-rt-public"
  }
}
resource "aws_route_table_association" "main_rta_elb_1a" {
  subnet_id = aws_subnet.main_subnet_elb_1a.id
  route_table_id = aws_route_table.main_rt_public.id
}
resource "aws_route_table_association" "main_rta_elb_1b" {
  subnet_id = aws_subnet.main_subnet_elb_1b.id
  route_table_id = aws_route_table.main_rt_public.id
}

resource "aws_route_table" "main_rt_private" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nwg.id
  }

  tags = {
    Name = "${var.domain}-${var.env}-main-rt-private"
  }
}
resource "aws_route_table_association" "main_rta_web_1a" {
  subnet_id      = aws_subnet.main_subnet_web_1a.id
  route_table_id = aws_route_table.main_rt_private.id
}
resource "aws_route_table_association" "main_rta_web_1b" {
  subnet_id      = aws_subnet.main_subnet_web_1b.id
  route_table_id = aws_route_table.main_rt_private.id
}
resource "aws_route_table_association" "main_rta_app_1a" {
  subnet_id      = aws_subnet.main_subnet_app_1a.id
  route_table_id = aws_route_table.main_rt_private.id
}
resource "aws_route_table_association" "main_rta_app_1b" {
  subnet_id      = aws_subnet.main_subnet_app_1b.id
  route_table_id = aws_route_table.main_rt_private.id
}
resource "aws_route_table_association" "main_rta_db_1a" {
  subnet_id      = aws_subnet.main_subnet_db_1a.id
  route_table_id = aws_route_table.main_rt_private.id
}
resource "aws_route_table_association" "main_rta_db_1b" {
  subnet_id      = aws_subnet.main_subnet_db_1b.id
  route_table_id = aws_route_table.main_rt_private.id
}