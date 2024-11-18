resource "aws_security_group" "alb" {
  name        = "${var.namespace}-application-load-balancer-sg"
  vpc_id      = var.vpc.vpc_id
  description = "Terraform load balancer security group"

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
    Name = "${var.namespace}-alb-sg"
  }
}

resource "aws_alb" "application_load_balancer" {
  name            = "${var.namespace}-alb"
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = var.vpc.public_subnets

  tags = {
    Name = "${var.namespace}-application-load-balancer"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.namespace}-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/ping"
    port                = "8443"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.namespace}-application-load-balancer-target-group"
  }
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }

  tags = {
    Name        = "${var.namespace}-application-load-balancer-http-listener"
    Environment = var.env_name
    Owner       = "Terraform"
  }
}
