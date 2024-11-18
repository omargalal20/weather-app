locals {
  instance_type = var.instance_type
  key_name      = var.key_name
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "tf_key_pair" {
  key_name   = local.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.key_pair_file_path
}

resource "aws_iam_instance_profile" "server_instance_profile" {
  name = "${var.namespace}-server-instance-profile"
  role = var.iam_role_name
}

resource "aws_instance" "server_instance" {
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = local.instance_type
  key_name                    = local.key_name
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.server.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.server_instance_profile.name

  root_block_device {
    volume_size = 50
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.cwd}/${local.key_name}.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "${path.cwd}/ec2-bootstrap-scripts"
    destination = "/home/ec2-user/ec2-bootstrap-scripts"

    on_failure = fail
    when       = create
  }

  provisioner "file" {
    source      = "${path.cwd}/docker"
    destination = "/home/ec2-user/docker"

    on_failure = fail
    when       = create
  }

  provisioner "remote-exec" {
    inline = [
      "for script in /home/ec2-user/ec2-bootstrap-scripts/*.sh; do sudo sed -i 's/\r//' \"$script\" && sudo chmod +x \"$script\"; done",
      "sudo /home/ec2-user/ec2-bootstrap-scripts/utility_packages_setup.sh",
      "sudo /home/ec2-user/ec2-bootstrap-scripts/docker_setup.sh"
    ]

    on_failure = fail
    when       = create
  }

  tags = {
    Name = "${var.namespace}-server-instance"
  }

  depends_on = [aws_key_pair.tf_key_pair]
}

resource "aws_security_group" "server" {
  name   = "${var.namespace}-server-sg"
  vpc_id = var.vpc.vpc_id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS-Inbound-Rule"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP-Inbound-Rule"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH-Inbound-Rule"
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Jenkins-Inbound-Rule"
  }
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Traefik-Inbound-Rule"
  }
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Portainer-Inbound-Rule"
  }
  ingress {
    from_port   = 9443
    to_port     = 9443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Portainer-Secure-Inbound-Rule"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.namespace}-server-sg"
  }
}

resource "aws_lb_target_group_attachment" "server_alb_attachment" {
  target_group_arn = var.aws_lb_target_group_arn
  target_id        = aws_instance.server_instance.id
  port             = 80
}
