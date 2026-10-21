resource "aws_security_group" "alb_sg" {
  name        = "${local.project_name}-alb-sg"
  description = "ALB security group allowing HTTP/HTTPS from internet"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTP to targets inside the VPC only"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = merge(local.tags, {
    Name = "${local.project_name}-alb-sg"
  })
}

resource "aws_security_group" "app_sg" {
  name        = "${local.project_name}-app-sg"
  description = "App security group allowing HTTP only from ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "HTTP for package updates via the NAT gateway"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS for package updates and AWS APIs via the NAT gateway"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${local.project_name}-app-sg"
  })
}

resource "aws_security_group" "db_sg" {
  name        = "${local.project_name}-db-sg"
  description = "DB security group allowing private access from app"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "DB from app only"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  # No egress rules: the database never initiates connections. Replies to allowed
  # inbound traffic still flow because security groups are stateful.

  tags = merge(local.tags, {
    Name = "${local.project_name}-db-sg"
  })
}


