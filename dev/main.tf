

data "aws_ami" "ubuntu_instance_ami" {
  most_recent = true
  owners      = [var.owner]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_key_pair" "rancher_key" {
  key_name           = "rancher_key"
  include_public_key = true
  filter {
    name   = "tag:Name"
    values = ["rancher_key"]
  }
}


output "pub_ip" {
  value = [for pub in aws_instance.rancherdemo : pub.public_ip]
}
resource "aws_instance" "rancherdemo" {
  count           = var.creat_instance ? length(var.name) : 0
  ami             = data.aws_ami.ubuntu_instance_ami.id
  instance_type   = var.instance_type
  key_name        = local.aws_key_pair
  security_groups = [aws_security_group.app_sg.id]
  subnet_id       = aws_subnet.public_subnet[0].id
  user_data = templatefile("${path.module}/template/bash.sh",
    {
    

  })

  
  root_block_device {
    volume_size = var.volume_size
    # GB
    volume_type = "gp2"
  }

  tags = {
    Name = "rancherdemo-${count.index + 1}" #${count.index + 1}
  }

  lifecycle {
    ignore_changes = [
      security_groups,
    ]
  }

}

resource "tls_private_key" "conapp_server" {
    algorithm =  "RSA"
    rsa_bits  = 4096
}
resource "aws_key_pair" "conapp_server_key" {
    key_name = var.keypair_name
    public_key = tls_private_key.conapp_server.public_key_openssh
  
}

output "private_key" {
  value     = tls_private_key.conapp_server.private_key_pem
  sensitive = true
}

//Creating a ALB for HA 
resource "aws_lb" "rancherdemo-alb" {
  count              = var.creat_instance ? 1 : 0
  name               = "rancherdemo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = slice(aws_subnet.public_subnet[*].id, 0, 2)
}

//creating target group
resource "aws_lb_target_group" "tg" {
  count       = var.creat_instance ? length(var.name) : 0
  name        = "rancherdemo-tg-bn"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
}
//target group association
resource "aws_lb_target_group_attachment" "tgattachment" {
  count            = var.creat_instance ? length(var.name) : 0
  target_group_arn = aws_lb_target_group.tg[count.index].arn
  target_id        = var.creat_instance ? aws_instance.rancherdemo[count.index].id : 0
  port             = 80
  depends_on = [
    aws_instance.rancherdemo
  ]
}

//creating ALB listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.rancherdemo-alb[0].arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
//Listener Rule 
resource "aws_lb_listener_rule" "rule" {
  count        = var.creat_instance ? 1 : 0
  listener_arn = aws_lb_listener.listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[count.index].arn
  }
  condition {
    path_pattern {
      values = ["/var/www/html/index.html"]
    }
  }
}