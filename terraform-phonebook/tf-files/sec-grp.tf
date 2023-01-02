//Creating SG for LB
resource "aws_security_group" "alb-sg" {
  name   = "ALBSecurityGroup"
  vpc_id = data.aws_vpc.selected.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF_ALBSecurityGroup"
  }
}

//Creating SG for EC2 Wevservere
resource "aws_security_group" "web-server-sg" {
  name   = "WebServerSecurityGroup"
  vpc_id = data.aws_vpc.selected.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF_WebServerSecurityGroup"
  }
}

//Creating SG for DB
resource "aws_security_group" "db-sg" {
  name   = "RDSSecurityGroup"
  vpc_id = data.aws_vpc.selected.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.web-server-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF_RDSSecurityGroup"
  }
}