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

resource "aws_key_pair" "tf-key-pair" {
  key_name   = local.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.key_pair_file_path
}


resource "aws_instance" "jenkins-instance" {
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = local.instance_type
  key_name                    = local.key_name
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.sg_allow_ssh_jenkins.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 40
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.prog/${local.key_name}.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "${path.cwd}/ec2-bootstrap-scripts"
    destination = "/home/${var.namespace}-admin/ec2-bootstrap-scripts/"

    on_failure = fail
    when       = create
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y dos2unix",
      "for script in /home/${var.namespace}-admin/vm-bootstrap-scripts/*.sh; do dos2unix $script && sudo chmod +x $script; done",
      "/home/${var.namespace}-admin/vm-bootstrap-scripts/utility_packages_setup.sh",
      "/home/${var.namespace}-admin/vm-bootstrap-scripts/docker_setup.sh",
    ]

    on_failure = fail
    when       = create
  }

  tags = {
    Name        = "${var.namespace}-jenkins-instance"
    Environment = var.env_name
    Owner       = "Terraform"
  }

  depends_on = [aws_key_pair.tf-key-pair]
}

resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name   = "${var.namespace}-jenkins-sg"
  vpc_id = var.vpc.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name        = "${var.namespace}-jenkins-sg"
    Environment = var.env_name
    Owner       = "Terraform"
  }
}
